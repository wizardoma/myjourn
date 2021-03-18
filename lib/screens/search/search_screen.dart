
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isTyping = false;
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
          if (isTyping)
            IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    isTyping = false;
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
              isTyping = true;
            });}
            else {
              setState(() {
                isTyping = false;
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
