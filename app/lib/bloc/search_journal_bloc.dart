import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/journal_events.dart';
import 'package:flutterfrontend/bloc/journal_state.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/services/repository/journal_repository.dart';

class SearchJournalBloc extends Bloc<JournalEvents, JournalState> {
  JournalRepository _repository;
  StreamSubscription streamSubscription;

  SearchJournalBloc(JournalRepository repository) : super(InitialJournalState()) {
    this._repository = repository?? JournalRepository.instance;
    }

  List<Journal> _journals = [];

  @override
  Stream<JournalState> mapEventToState(JournalEvents event) async*{
    yield InitialJournalState();
    if (event is SearchJournalEvent){
      yield LoadingState();
      yield await searchJournal(event);
    }
  }

  Future<JournalState> searchJournal(SearchJournalEvent event)async {


    try {
        List<Journal> result;
        if (_journals.length == 0) {
          result = (await _repository.all()).map((e) =>
              Journal.fromNewMap(e)).toList().where((element) =>
              element.body.contains(event.query)).toList();
        }
        else {
          result = _journals.where((element) =>
              element.body.contains(event.query)).toList();
        }
        if (result.length > 0) {
          return SearchFound(result);
        }
        return SearchEmpty();
      }
      catch (e) {
        print(e);

        return SearchEmpty();
      }
  }

  dispose() {
    streamSubscription.cancel();
  }
}