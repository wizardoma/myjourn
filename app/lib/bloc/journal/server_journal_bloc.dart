import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/journal/journal_bloc.dart';
import 'package:flutterfrontend/bloc/journal/server_journal_event.dart';
import 'package:flutterfrontend/bloc/journal/server_journal_state.dart';

class ServerJournalBloc extends Bloc< ServerJournalEvent,ServerJournalState> {

  JournalBloc _journalBloc;

  StreamSubscription _streamSubscription;
  ServerJournalBloc(this._journalBloc, ) : super(ServerJournalInitialState()){
    _streamSubscription = _journalBloc.stream.listen((state) {

    });
  }

  @override
  Stream<ServerJournalState> mapEventToState(ServerJournalEvent event) {
    if (event is FetchServerJournals)
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }


}