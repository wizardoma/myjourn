import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/journal_state.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/services/repository/journal_repository.dart';

import 'journal_events.dart';
import 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvents, JournalState> {
  JournalRepository _repository;

  List<Journal> _journals = [];

  JournalBloc() : super(InitialJournalState()) {
    _repository = _repository ?? JournalRepository.instance;
//    add(FetchJournalsEvent());
  }

  @override
  Stream<JournalState> mapEventToState(JournalEvents event) async* {
    yield InitialJournalState();
    if (event is AddJournalEvent) {
      yield LoadingState();
      yield await insertJournal(event);
    }

    if (event is DeleteJournalEvent) {
      yield LoadingState();
      yield await deleteJournal(event);
    }

    if (event is EditJournalEvent) {
      yield LoadingState();
      yield await editJournal(event);
    }

    if (event is FetchJournalsEvent) {
      yield LoadingState();
      yield await fetchJournals();
    }

    if (event is FetchJournalEvent) {
      yield LoadingState();
      yield await fetchJournalByID(event);
    }
  }

  Future<JournalState> fetchJournals() async {
    try {
      var journals =
          (await _repository.all()).map((e) => Journal.fromNewMap(e)).toList();
      _journals = journals;
      return FetchJournalsSuccess([..._journals]);
    } catch (e) {
      return FetchJournalsFailure();
    }
  }

  Future<JournalState> editJournal(EditJournalEvent event) async {
    try {
      var result = await _repository.update(Journal.toMap(event.journal));
      if (databaseOpWasSuccessful(result)) {
//        fetchJournals();
        return EditSuccess(event.journal);
      }
      return EditFailure();
    } catch (e) {
      return EditFailure();
    }
  }

  Future<JournalState> insertJournal(AddJournalEvent event) async {
    try {
      var result = await _repository.insert(Journal.toMap(event.journal));
      if (databaseOpWasSuccessful(result)) {
//        fetchJournals();
        return AddJournalSuccess(event.journal);
      } else
        return AddJournalFailure();
    } catch (e) {
      return AddJournalFailure();
    }
  }

  bool databaseOpWasSuccessful(int result) {
    return result != 0;
  }

  Future<JournalState> deleteJournal(DeleteJournalEvent event) async {
    try {
      var result = await _repository.delete(event.id);
      if (databaseOpWasSuccessful(result)) {
//        fetchJournals();
        return DeleteSuccess();
      } else
        return DeleteFailure();
    } catch (e) {
      return DeleteFailure();
    }
  }

  Future<JournalState> fetchJournalByID(FetchJournalEvent event) async {
    try {
      var result = await _repository.getById(event.id);
      if (result.length > 0) {
        return FetchJournalSuccess(Journal.fromNewMap(result[0]));
      }
      if (result.length == 0) {
        return FetchJournalEmpty();
      }
    } catch (e) {
      print(e);
      return FetchJournalEmpty();
    }
  }

  Journal getJournalById(int id) {
    return journals.firstWhere((element) => element.id == id);
  }

  List<Journal> get journals => [..._journals];
}
