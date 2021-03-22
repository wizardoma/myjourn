import 'package:flutter/widgets.dart';
import 'package:flutterfrontend/models/journal.dart';
import '../services/repository/journal_repository.dart';

class JournalProvider with ChangeNotifier {
  List<Journal> _journals = [
    Journal(
        1,
        "Tomorrow will be awesome for me, "
            "I can't even begin to think how i would have learned so much in programming to be this good."
            "I know am gonna stand out in this career. I just gotta keep pushing everyday. "
            "I will never Stop no matter what happens. This is the heart and mentality of a warrior",
        DateTime.now()),
    Journal(2, "I have started serious work on Dart and Flutter",
        DateTime.now().subtract(Duration(days: 1))),
    Journal(3, "Am so grateful for everything ",
        DateTime.now().subtract(Duration(minutes: 10))),
    Journal(4, "How are you doing? Ill be back to you",
        DateTime.now().subtract(Duration(days: 14))),
    Journal(5, "I am on track on making my first million naira",
        DateTime.now().subtract(Duration(hours: 24))),
    Journal(6, "I am really grateful for life and everything it gave me",
        DateTime.now().subtract(Duration(hours: 35))),
    Journal(7, "I;ve not been able to meet up with certain things so far",
        DateTime.now().subtract(Duration(minutes: 34))),
    Journal(
        8,
        "The more i work at Shoprite, they more i realize its not for me",
        DateTime.now().subtract(Duration(days: 10, hours: 3))),
    Journal(9, "I am going to be a very great software developer",
        DateTime.now().subtract(Duration(minutes: 10))),
    Journal(
        10,
        "I am going to venture fully into being a professional software developer",
        DateTime.now().subtract(Duration(seconds: 48))),
  ];

  List<Journal> _dbJournals = [];

  get journals {
    return [..._dbJournals];
  }

  get size {
    return _dbJournals.length;
  }

  Journal findById(int id) {
    try {
      return _dbJournals.firstWhere((element) => element.id == id);}
      catch (e){
      return null;
    }
  }

  Future<bool> addJournal(Journal journal) async{
    int result = await JournalRepository.instance.insert(Journal.toMap(journal));
    await fetchJournals();
    print("result of saving ${Journal.toMap(journal)} was : $result");
    notifyListeners();

    return databaseOpWasSuccessful(result);
  }

  Future<bool> deleteJournal(int id) async {
    int result = await JournalRepository.instance.delete(id);
    await fetchJournals();
    notifyListeners();
    return databaseOpWasSuccessful(result);
  }

  Future<bool> editJournal(Journal journal) async{
    int result = await JournalRepository.instance.update(Journal.toMap(journal));
    print("result of updating is: $result");
    await fetchJournals();
    notifyListeners();
    return databaseOpWasSuccessful(result);
  }

  Future<List<Journal>> fetchJournals() async {
    var allJournals = await JournalRepository.instance.all();
    var journalList = allJournals.map((e) {
      return Journal.fromMap(e);
    }).toList();
    _dbJournals = journalList;

    return [..._dbJournals];
  }

  bool databaseOpWasSuccessful(int result) {
    return result != 0;
  }

}
