import 'package:flutterfrontend/models/server_journal.dart';

abstract class ServerJournalEvent {}

class CreateServerJournal extends ServerJournalEvent{
  final ServerJournal journal;

  CreateServerJournal(this.journal);
}
class EditServerJournal extends ServerJournalEvent {
  final ServerJournal journal;

  EditServerJournal(this.journal);
}
class DeleteServerJournal extends ServerJournalEvent {
  final int dbId;

  DeleteServerJournal(this.dbId);
}
class FetchServerJournals extends ServerJournalEvent {}