import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/journal/journal_events.dart';
import 'package:flutterfrontend/bloc/journal/journal_state.dart';
import 'package:flutterfrontend/bloc/search/search_journal_bloc.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/screens/home/journal_list_items.dart';
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
          onSubmitted: (query) => searchJournals(query, context),
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
          : BlocBuilder<SearchJournalBloc, JournalState>(

              builder: (BuildContext context, state) {
                if (state is InitialJournalState || state is LoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchEmpty) {
                  return Center(
                    child: Text("No Search found"),
                  );
                } else if (state is SearchFound) {
                  return JournalListItems(state.journals); }
                else return Container();
              },
            ),
    );
  }

  void searchJournals(String query, BuildContext context) {
    if (query == null || query.isEmpty) {
      return;
    }
    context.read<SearchJournalBloc>().add(SearchJournalEvent(query));
    setState(() {
      hasSearched = true;
    });
  }

  void noSearchFound(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("No Search found"),
    ));
  }
}
