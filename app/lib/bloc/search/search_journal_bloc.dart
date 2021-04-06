import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/journal/journal_bloc.dart';
import 'package:flutterfrontend/bloc/journal/journal_events.dart';
import 'package:flutterfrontend/bloc/journal/journal_state.dart';
import 'package:flutterfrontend/models/journal.dart';

class SearchJournalBloc extends Bloc<JournalEvents, JournalState> {
  JournalBloc journalBloc;
  StreamSubscription _streamSubscription;

  SearchJournalBloc({this.journalBloc}) : super(InitialJournalState()) {
    this._journals = journalBloc.journals;
    _streamSubscription = journalBloc.stream.listen((event) {
      if (state is FetchJournalsSuccess){
        this._journals = (state as FetchJournalsSuccess).journals;
      }
    });
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
          return SearchEmpty();
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

  @override
  close() async {
    super.close();
    _streamSubscription.cancel();
  }

}