import 'package:flutter/material.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/providers/journal_provider.dart';
import 'package:flutterfrontend/screens/home/journal_list_item.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Journal> searchResults = [];
  bool hasContent = false;
  bool hasSearched = false;
  TextEditingController searchController;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            if (hasContent)
              IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      hasContent = false;
                      searchController.clear();
                    });
                  })
          ],
          title: TextField(
            autofocus: true,
            controller: searchController,
            onChanged: (val) {
              if (val == null || val.isNotEmpty) {
                setState(() {
                  hasContent = true;
                });
              } else {
                setState(() {
                  hasContent = false;
                });
              }
            },
            onSubmitted: (query) => searchJournals(query),
            style: TextStyle(
              color: Colors.white,
            ),
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                focusColor: Colors.white,
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey.shade300)),
          ),
        ),
        body: !hasSearched
            ? Container()
            : searchResults.length == 0
                ?
//      noSearchFound(context);
                Center(
                    child: Text("No Search found"),
                  )
                : ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, int index) {
                      return JournalListItem(searchResults[index]);
                    }));
  }

  void searchJournals(String query) {
    if (query == null || query.isEmpty){
      return;
    }
    setState(() {
      searchResults = Provider.of<JournalProvider>(context, listen: false)
          .searchJournal(query);
      hasSearched = true;
    });
  }

  void noSearchFound(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("No Search found"),
    ));
  }
}
