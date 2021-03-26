import 'package:flutter/material.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/providers/journal_provider.dart';
import 'package:flutterfrontend/screens/home/journal_list_items.dart';
import 'package:flutterfrontend/screens/journal/new_journal_screen.dart';
import 'package:provider/provider.dart';

class JournalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final journals = Provider.of<JournalProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(NewJournalScreen.routeName,
                arguments: {"isNew": true});
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: Provider.of<JournalProvider>(context).fetchJournals(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Journal>> snapshot) {

            return !hasFinishedLoading(snapshot.connectionState)
                ? Center(child: CircularProgressIndicator())
                : hasGotData(snapshot.data)
                    ? Center(
                        child: Text("No Journals"),
                      )
                    : JournalListItems(snapshot.data);
          },
        ));
  }

  bool hasFinishedLoading(ConnectionState state) {
    return state == ConnectionState.done;
  }

  bool hasGotData(List<Journal> data) {
    return data == null || data.length == 0;
  }
}
