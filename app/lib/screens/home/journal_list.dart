import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/journal_bloc.dart';
import 'package:flutterfrontend/bloc/journal_events.dart';
import 'package:flutterfrontend/bloc/journal_state.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/providers/journal_provider.dart';
import 'package:flutterfrontend/screens/home/journal_list_items.dart';
import 'package:flutterfrontend/screens/journal/new_journal_screen.dart';
import 'package:provider/provider.dart';

class JournalList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
//    final journals = Provider.of<JournalProvider>(context);
    JournalBloc _journalBloc = BlocProvider.of<JournalBloc>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(NewJournalScreen.routeName,
              arguments: {"isNew": true});
        },
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<JournalBloc, JournalState>(
          // ignore: missing_return
          builder: (BuildContext context, state) {
        if (state is FetchJournalsSuccess) {
          return state.journals.length == 0
              ? Center(
                  child: Text("No Journals"),
                )
              : JournalListItems(state.journals);
        }
        if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  bool hasFinishedLoading(ConnectionState state) {
    return state == ConnectionState.done;
  }

  bool hasGotData(List<Journal> data) {
    return data == null || data.length == 0;
  }
}
