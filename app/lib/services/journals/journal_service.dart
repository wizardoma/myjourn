import 'package:dio/dio.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/services/auth/authentication_service.dart';
import 'package:flutterfrontend/services/repository/journal_repository.dart';
import 'package:flutterfrontend/services/repository/journal_server_repository.dart';
import 'package:flutterfrontend/services/repository/server_const.dart';
import 'package:flutterfrontend/services/requests/save_journal_request.dart';
import 'package:flutterfrontend/util/response_utils.dart';

class JournalService with ResponseUtil {
  final JournalRepository localRepository;
  final JournalServerRepository serverRepository;
  final AuthenticationService authenticationService;

  JournalService(
      {this.localRepository,
      this.serverRepository,
      this.authenticationService});

  Future<Journal> insertJournal(Journal journal) async {
    try {
      var result = await _saveToDb(journal);
      if (_databaseOpWasSuccessful(result)) {
        // send a future request to create journal in the backend
        _saveToServer(journal);
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
      if (_databaseOpWasSuccessful(result)) {
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
      if (_databaseOpWasSuccessful(result)) {
        _deleteFromServer(id);
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<List<Journal>> fetchJournals() async {
    try {
      var journals =
      (await localRepository.all()).map((e) => Journal.fromMap(e)).toList();

      return journals;
    } catch (e) {
      return null;
    }
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
    var request = CreateServerJournalRequest.fromJournalMap(journal.toMap());
    if (journal.serverId != null) {
      serverRepository
          .edit(journal.id, FormData.fromMap(request.toMap()), headers)
          .then((response) {
        if (isOk(response.statusCode)) {
          _updateToDb(Journal.fromServer(response.data));
        }
      });
    }
  }

  Future<void> _saveToServer(Journal journal) async {
    var headers = await _getHeaders();
    var request = CreateServerJournalRequest.fromJournalMap(journal.toMap());
    print("journal request to server ${request.toMap()}");

    serverRepository
        .save(FormData.fromMap(request.toMap()), headers)
        .then((response) {
      // When response, if successful, update local journal with server id, else do nothing, fetching journal event retries this operation
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
}
