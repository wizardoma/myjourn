import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/auth/auth_bloc.dart';
import 'package:flutterfrontend/bloc/auth/authentication_state.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/services/journals/journal_service.dart';

import 'journal_events.dart';
import 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvents, JournalState> {
  final JournalService _service;
  final AuthenticationBloc _authenticationBloc;
  StreamSubscription _streamSubscription;

  List<Journal> _journals = [];

  JournalBloc(this._service, this._authenticationBloc)
      : super(InitialJournalState()) {
    _streamSubscription = _authenticationBloc.stream.listen((state) {
      if (state is NotAuthenticated) {
        _service.syncDbOnLogout();
        this._journals = [];
      }
    });
  }

  @override
  Stream<JournalState> mapEventToState(JournalEvents event) async* {
    yield InitialJournalState();
    if (event is AddJournalEvent) {
      yield LoadingState();
      yield await insertJournal(event);
      this.add(FetchJournalsEvent());
    }

    if (event is DeleteJournalEvent) {
      yield LoadingState();
      yield await deleteJournal(event);
      this.add(FetchJournalsEvent());
    }

    if (event is EditJournalEvent) {
      yield LoadingState();
      yield await editJournal(event);
      this.add(FetchJournalsEvent());
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
    var journals = await _service.fetchJournals();
    if (journals != null) {
      _journals = journals;
      return FetchJournalsSuccess([...journals]);
    } else
      return FetchJournalsFailure();
  }

  Future<JournalState> editJournal(EditJournalEvent event) async {
    var journal = await _service.editJournal(event.journal);
    if (journal != null) {
      return EditSuccess(event.journal);
    }
    return EditFailure();
  }

  Future<JournalState> insertJournal(AddJournalEvent event) async {
    var journal = await _service.insertJournal(event.journal);
    if (journal != null) {
      return AddJournalSuccess(event.journal);
    } else
      return AddJournalFailure();
  }

  Future<JournalState> deleteJournal(DeleteJournalEvent event) async {
    var result = await _service.deleteJournal(event.id);
    if (result) {
      return DeleteSuccess();
    } else
      return DeleteFailure();
  }

  Future<JournalState> fetchJournalByID(FetchJournalEvent event) async {
    var journal = await _service.fetchJournalById(event.id);
    if (journal != null) {
      return FetchJournalSuccess(journal);
    }
    return FetchJournalEmpty();
  }

  Journal getJournalById(int id) {
    return journals.firstWhere((element) => element.id == id);
  }

  List<Journal> get journals => [..._journals];

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
