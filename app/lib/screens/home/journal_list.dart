import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/journal_bloc.dart';
import 'package:flutterfrontend/bloc/journal_state.dart';
import 'package:flutterfrontend/screens/home/journal_list_items.dart';
import 'package:flutterfrontend/screens/journal/new_journal_screen.dart';

class JournalList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var bloc= BlocProvider.of<JournalBloc>(context);

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
}
