
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool hasContent = false;
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
            if (val==null || val.isNotEmpty) {
            setState(() {
              hasContent = true;
            });}
            else {
              setState(() {
                hasContent = false;
              });
            }
          },
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
    );
  }
}
