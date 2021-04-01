import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/journal_state.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/services/repository/journal_repository.dart';

import 'journal_events.dart';
import 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvents, JournalState>{
  JournalRepository _repository;

  List<Journal> _journals = [];

  JournalBloc(JournalRepository repository) : _repository = repository?? JournalRepository.instance ,super(InitialJournalState());

  @override
  Stream<JournalState> mapEventToState(JournalEvents event) async*{
    yield InitialJournalState();
    if (event is AddJournalEvent){
      yield await insertJournal(event);
    }

    if (event is DeleteJournalEvent){
      yield await deleteJournal(event);
    }

    if (event is EditJournalEvent){
      yield await editJournal(event);
    }

    if (event is FetchJournalsEvent){
      yield LoadingState();
      yield await fetchJournals();
    }
  }

  Future<JournalState> fetchJournals() async{
    try {
      var journals = (await _repository.all()).map((e) => Journal.fromNewMap(e)).toList();
      _journals = journals;
      return FetchJournalsSuccess([..._journals]);
    }
    catch (e) {
      return FetchJournalsFailure();
    }
  }

  Future<JournalState> editJournal(EditJournalEvent event)async {
    try {
      var result = await _repository.update(Journal.toMap(event.journal));
      if (databaseOpWasSuccessful(result)){
        return EditSuccess();
      }
      return EditFailure();
    }
    catch (e) {
      return EditFailure();
    }
  }

  Future<JournalState> insertJournal(AddJournalEvent event) async{
    try {
      var result = await _repository.insert(Journal.toMap(event.journal));
      if (databaseOpWasSuccessful(result))
      return AddJournalSuccess();
      else return AddJournalFailure();
    }
    catch (e) {
      return AddJournalFailure();
    }
  }

  bool databaseOpWasSuccessful(int result) {
    return result != 0;
  }

  Future<JournalState> deleteJournal(DeleteJournalEvent event) async{
    try {
      var result = await _repository.delete(event.id);
      if (databaseOpWasSuccessful(result)){
        return  DeleteSuccess();

      }
      else return DeleteFailure();
    }
    catch (e) {
      return DeleteFailure();
    }
  }

}