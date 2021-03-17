import 'package:flutter/widgets.dart';
import 'package:flutterfrontend/models/journal.dart';

class JournalProvider with ChangeNotifier {

  List<Journal> _journals = [];

  get journals {
    return [..._journals];
  }

  void addJournal(Journal journal) {
    this._journals.add(journal);
  }

  void deleteJournal(String id){
    this._journals.removeWhere((element) => element.id == id);

  }

  void editJournal(String id, String body){
    Journal journal = this._journals.firstWhere((element) => element.id == id);
    if (journal == null){
      return;
    }

    journal.body = body;
    addJournal(journal);

  }

}