import 'package:flutter/material.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/providers/journal_provider.dart';
import 'package:flutterfrontend/screens/home/journal_list_item.dart';
import 'package:flutterfrontend/screens/journal/new_journal_screen.dart';
import 'package:flutterfrontend/util/journal_util.dart';
import 'package:provider/provider.dart';

class JournalList extends StatelessWidget with JournalUtils{
  @override
  Widget build(BuildContext context) {
//    final journals = Provider.of<JournalProvider>(context);
    return Scaffold(
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
                var mappedJournals = listToMapView(snapshot.data);
            return !hasFinishedLoading(snapshot.connectionState)
                ? Center(child: CircularProgressIndicator())
                : hasGotData(snapshot.data)
                    ? Center(
                        child: Text("No Journals"),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 2,
                          );
                        },
                        itemCount: mappedJournals.length,
                        itemBuilder: (context, index) {

                          return JournalListItem(mappedJournals.values.elementAt(index));
                        },
                      );
          },
        ));
  }

  bool hasFinishedLoading(ConnectionState state) {
    return state == ConnectionState.done;
  }

  bool hasGotData(List<Journal> data){
    return data == null || data.length == 0;
  }
}
