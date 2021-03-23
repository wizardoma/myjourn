import 'package:flutter/widgets.dart';
import 'package:flutterfrontend/models/journal.dart';
import '../services/repository/journal_repository.dart';

class JournalProvider with ChangeNotifier {
  List<Journal> _dbJournals = [];

  List<Journal> get journals {
    return [..._dbJournals];
  }

  get size {
    return _dbJournals.length;
  }

  Journal findById(int id) {
    try {
      return _dbJournals.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<bool> addJournal(Journal journal) async {
    int result =
        await JournalRepository.instance.insert(Journal.toMap(journal));
    await fetchJournals();
    notifyListeners();

    return databaseOpWasSuccessful(result);
  }

  Future<bool> deleteJournal(int id) async {
    int result = await JournalRepository.instance.delete(id);
    await fetchJournals();
    notifyListeners();
    return databaseOpWasSuccessful(result);
  }

  Future<bool> editJournal(Journal journal) async {
    int result =
        await JournalRepository.instance.update(Journal.toMap(journal));
    await fetchJournals();
    notifyListeners();
    return databaseOpWasSuccessful(result);
  }

  List<Journal> searchJournal(String query) {
    return _dbJournals
        .where((element) =>
            element.body.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }


  Future<List<Journal>> fetchJournals() async {
    var allJournals = await JournalRepository.instance.all();
    var journalList = allJournals.map((e) {
      return Journal.fromNewMap(e);
    }).toList();
    _dbJournals = journalList;

    return [..._dbJournals];
  }

  bool databaseOpWasSuccessful(int result) {
    return result != 0;
  }
}
