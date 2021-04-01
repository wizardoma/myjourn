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

class InitialJournalState extends JournalState{}
class DeleteSuccess extends JournalState{}
class DeleteFailure extends JournalState{}
class EditSuccess extends JournalState{}
class EditFailure extends JournalState{}
class FetchJournalsSuccess extends JournalState{
  final List<Journal> _journals;

  FetchJournalsSuccess(this._journals);
  get journals => _journals;
}
class FetchJournalsFailure extends JournalState{}
class AddJournalSuccess extends JournalState{

}
class AddJournalFailure extends JournalState{}
