import 'package:flutter/material.dart';
import 'package:flutterfrontend/providers/journal_provider.dart';
import 'package:flutterfrontend/screens/home/journal_list_item.dart';
import 'package:provider/provider.dart';

class JournalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final journals = Provider.of<JournalProvider>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        body: journals.size == 0
            ? Center(
                child: Text("No Journals"),
              )
            : ListView.builder(
                itemCount: journals.size,
                itemBuilder: (context, index) =>
                    JournalListItem(journals.journals[index]),
              ));
  }
}
