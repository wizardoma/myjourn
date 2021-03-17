import 'package:flutter/widgets.dart';
import 'package:flutterfrontend/models/journal.dart';

class JournalProvider with ChangeNotifier {
  List<Journal> _journals = [
    Journal("1", "Tomorrow will be awesome for me", DateTime.now()),
    Journal("2", "I have started serious work on Dart and Flutter",
        DateTime.now().add(Duration(days: 10))),
    Journal("3", "Am so grateful for everything ",
        DateTime.now().add(Duration(minutes: 10))),
    Journal("4", "How are you doing? Ill be back to you",
        DateTime.now().add(Duration(days: 14))),
    Journal("5", "I am on track on making my first million naira",
        DateTime.now().add(Duration(hours: 10))),
    Journal("6", "I am really grateful for life and everything it gave me",
        DateTime.now().add(Duration(hours: 35))),
    Journal("7", "I;ve not been able to meet up with certain things so far",
        DateTime.now().add(Duration(minutes: 34))),
    Journal(
        "8",
        "The more i work at Shoprite, they more i realize its not for me",
        DateTime.now().add(Duration(days: 40, hours: 3))),
    Journal("9", "I am going to be a very great software developer",
        DateTime.now().add(Duration(minutes: 10))),
    Journal(
        "10",
        "I am going to venture fully into being a professional software developer",
        DateTime.now().add(Duration(seconds: 48))),
  ];

  get journals {
    return [..._journals];
  }

  get size {
    return _journals.length;
  }

  void addJournal(Journal journal) {
    this._journals.add(journal);
  }

  void deleteJournal(String id) {
    this._journals.removeWhere((element) => element.id == id);
  }

  void editJournal(String id, String body) {
    Journal journal = this._journals.firstWhere((element) => element.id == id);
    if (journal == null) {
      return;
    }

    journal.body = body;
  }
}
