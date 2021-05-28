import 'package:dio/dio.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/services/auth/authentication_service.dart';
import 'package:flutterfrontend/services/preferences/journal_preferences.dart';
import 'package:flutterfrontend/services/repository/journal_repository.dart';
import 'package:flutterfrontend/services/repository/journal_server_repository.dart';
import 'package:flutterfrontend/services/repository/server_const.dart';
import 'package:flutterfrontend/services/requests/save_journal_request.dart';
import 'package:flutterfrontend/services/user/user_service.dart';
import 'package:flutterfrontend/util/response_utils.dart';

class JournalService with ResponseUtil {
  final JournalRepository localRepository;
  final JournalServerRepository serverRepository;
  final AuthenticationService authenticationService;
  final UserService userService;
  JournalPreferences _journalPreferences = JournalPreferences();

  JournalService(
      {this.localRepository,
      this.serverRepository,
      this.authenticationService,
      this.userService});

  Future<Journal> insertJournal(Journal journal) async {
    try {
      var result = await _saveToDb(journal);
      bool isGuest = await isGuestUser();
      if (_databaseOpWasSuccessful(result)) {
        // send a future request to create journal in the backend if its not a guest user
        if (!isGuest) _saveToServer(journal);
        return journal;
      } else
        return null;
    } catch (e) {
      return null;
    }
  }

  Future<Journal> editJournal(Journal journal) async {
    try {
      var result = await _updateToDb(journal);
      bool isGuest = await isGuestUser();
      // do not update to the server if its guest user
      if (_databaseOpWasSuccessful(result) && !isGuest) {
        // if journal is not synced with server, then sync
        if (journal.serverId == null) {
          _saveToServer(journal);
        } else {
          _updateToServer(journal);
        }
        return journal;
      } else
        return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteJournal(int id) async {
    try {
      var result = await localRepository.delete(id);
      bool isGuest = await isGuestUser();
      if (_databaseOpWasSuccessful(result) && !isGuest) {
        _deleteFromServer(id);
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<List<Journal>> fetchJournals() async {
    dynamic hasSynced = await _journalPreferences.getServerSync();
    bool isGuest = await isGuestUser();

    if ((hasSynced == null || !hasSynced) && !isGuest) {
      var hasSyncedToLocal = await _attemptToSyncDbWithPhone();
      if (hasSyncedToLocal) _journalPreferences.setServerSync(true);
    } else {
      _attemptToSyncDbWithPhone();
    }
    try {
      var journals =
          (await localRepository.all()).map((e) => Journal.fromMap(e)).toList();
      if (journals.length > 0 && !isGuest) {
        _attemptToSyncWithServer([...journals]);
      }

      return journals;
    } catch (e) {
      return null;
    }
  }

  Future<Journal> fetchJournalById(int id) async {
    try {
      var result = await localRepository.getById(id);
      if (result.length > 0) {
        return Journal.fromMap(result[0]);
      }
      if (result.length == 0) {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  void syncDbOnLogout() async {
    // get all journals from local, sync with the server, then delete all from the phone
    var allJournals = await localRepository.all();
    var localJournals = allJournals.map((e) => Journal.fromMap(e)).toList();
    bool isGuest = await isGuestUser();
    if (!isGuest) await _attemptToSyncWithServer(localJournals);
    await _journalPreferences.setServerSync(false);
    await localRepository.purge();
  }

  Future<void> _deleteFromServer(int id) async {
    var headers = await _getHeaders();
    serverRepository.delete(id, headers).then((response) {
      if (!isOk(response.statusCode)) {
        print(response.errors);
      }
    });
  }

  Future<void> _updateToServer(Journal journal) async {
    var headers = await _getHeaders();
    var request = CreateServerJournalRequest.fromJournal(journal.toMap());
    serverRepository
        .edit(journal.serverId, FormData.fromMap(request.toMap()), headers)
        .then((response) {
      if (isOk(response.statusCode)) {
        _updateToDb(Journal.fromServer(response.data));
      }
    });
  }

  Future<void> _saveToServer(Journal journal) async {
    var headers = await _getHeaders();
    var request = CreateServerJournalRequest.fromJournal(journal.toMap());

    serverRepository
        .save(FormData.fromMap(request.toMap()), headers)
        .then((response) {
      //  if successful response, update local journal with server id, else do nothing, fetching journal event retries this operation
      if (isCreated(response.statusCode)) {
        _updateToDb(Journal.fromServer(response.data));
      }
    });
  }

  Future<int> _saveToDb(Journal journal) async {
    return await localRepository.insert(journal.toMap());
  }

  Future<int> _updateToDb(Journal journal) async {
    return await localRepository.update(journal.toMap());
  }

  Future<Map<String, dynamic>> _getHeaders() async {
    var token = await authenticationService.getToken();
    return {
      "${ServerConstants.authHeaderName}":
          "${ServerConstants.tokenPrefix}$token"
    };
  }

  bool _databaseOpWasSuccessful(int result) {
    return result != 0;
  }

  Future<void> _attemptToSyncWithServer(List<Journal> journals) async {
    // if the server id is null, then sync with server
    journals.where((journal) => journal.serverId == null).forEach((journal) {
      _saveToServer(journal);
    });
  }

  Future<List<Journal>> _fetchServerJournals() async {
    var headers = await _getHeaders();
    var response = await serverRepository.getAll(headers);
    if (response.statusCode == 200) {
      print(response.data);
      var journals =
          (response.data as List).map((e) => Journal.fromServer(e)).toList();
      return journals;
    }
    return null;
  }

  Future<bool> _attemptToSyncDbWithPhone() async {
    var serverJournals = await _fetchServerJournals();

    int counter = 0;
    if (serverJournals != null || serverJournals.length > 0) {
      serverJournals.forEach((journal) async {
        ++counter;
        var journalDb = await fetchJournalById(journal.id);
        if (journalDb == null) {
          await _saveToDb(journal);
        }
      });
      while (counter != serverJournals.length) {
        await Future.delayed(Duration(milliseconds: 100));
      }
    }

    return counter == serverJournals.length;
  }

  Future<bool> isGuestUser() async {
    var user = await userService.getCachedUser();
    if (user == null) return true;
    return user.id == 0;
  }
}
