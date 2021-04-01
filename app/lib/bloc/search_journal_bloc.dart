import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/journal_bloc.dart';
import 'package:flutterfrontend/bloc/journal_events.dart';
import 'package:flutterfrontend/bloc/journal_state.dart';
import 'package:flutterfrontend/services/repository/journal_repository.dart';

class SearchJournalBloc extends Bloc<JournalEvents, JournalState> {
  final JournalBloc _journalBloc;

  SearchJournalBloc(JournalBloc journalBloc) : _journalBloc = JournalBloc(), super(SearchEmpty());

  @override
  Stream<JournalState> mapEventToState(JournalEvents event) async*{
    // TODO: implement mapEventToState
    if (event is SearchJournalEvent){
      yield searchJournal(event);
    }
  }

  JournalState searchJournal(SearchJournalEvent event) {
      try {
        _repository.
      }
  }

}