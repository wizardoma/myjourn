import 'package:flutterfrontend/models/server_journal.dart';

abstract class ServerJournalState {}

class ServerJournalInitialState extends ServerJournalState{}

class EditServerJournalSuccess extends ServerJournalState {
  final ServerJournal journal;

  EditServerJournalSuccess(this.journal);
}

class EditServerJournalFailure extends ServerJournalState {
  final Map<String, dynamic> errors;

  EditServerJournalFailure(this.errors);
}

class DeleteServerJournalSuccess extends ServerJournalState {}

class DeleteServerJournalFailure extends ServerJournalState {
  final Map<String, dynamic> errors;

  DeleteServerJournalFailure(this.errors);
}

class CreateServerJournalSuccess extends ServerJournalState {
  final ServerJournal journal;

  CreateServerJournalSuccess(this.journal);
}

class CreateServerJournalFailure extends ServerJournalState {
  final Map<String, dynamic> errors;

  CreateServerJournalFailure(this.errors);
}

class FetchServerJournalsSuccess extends ServerJournalState {
  final List<ServerJournal> journals;

  FetchServerJournalsSuccess(this.journals);
}

class FetchServerJournalFailure extends ServerJournalState {
  final Map<String, dynamic> errors;

  FetchServerJournalFailure(this.errors);
}
