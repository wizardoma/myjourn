import 'package:flutterfrontend/models/journal.dart';

abstract class JournalEvents {
  const JournalEvents();
}

class AddJournalEvent extends JournalEvents {
  final Journal journal;

  AddJournalEvent(this.journal);
}

class SearchJournalEvent extends JournalEvents {
  final String query;

  SearchJournalEvent(this.query);
}

class GetJournalsEvent extends JournalEvents{

}

class DeleteJournalEvent extends JournalEvents {
  final String id;

  DeleteJournalEvent(this.id);
}

class EditJournalEvent extends JournalEvents{
  final Journal journal;

  EditJournalEvent(this.journal);
}