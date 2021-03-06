import 'package:flutterfrontend/models/journal.dart';

abstract class JournalState {
    const JournalState();
}

class SearchEmpty extends JournalState{}
class SearchFound extends JournalState {
  final List<Journal> _journals;

  SearchFound(this._journals);
  get journals => _journals;
}
class FetchJournalSuccess extends JournalState {
  final Journal journal;

  FetchJournalSuccess(this.journal);
}
class FetchJournalEmpty extends JournalState{}
class LoadingState extends JournalState{}
class InitialJournalState extends JournalState{}
class DeleteSuccess extends JournalState{}
class DeleteFailure extends JournalState{}
class EditSuccess extends JournalState{
  final Journal journal;

  EditSuccess(this.journal);
}
class EditFailure extends JournalState{}
class FetchJournalsSuccess extends JournalState{
  final List<Journal> _journals;

  FetchJournalsSuccess(this._journals);
  get journals => _journals;
}
class FetchJournalsFailure extends JournalState{}
class AddJournalSuccess extends JournalState{
  final Journal journal;

  AddJournalSuccess(this.journal);

}
class AddJournalFailure extends JournalState{}
