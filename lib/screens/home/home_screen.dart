import 'package:flutter/material.dart';
import 'package:flutterfrontend/screens/calender/calender_screen.dart';
import 'package:flutterfrontend/screens/home/journal_list.dart';
import 'package:flutterfrontend/screens/more/more_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("MYJOURN"),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          actions: [
            DropdownButton(icon: Icon(Icons.more_vert), items: [
              DropdownMenuItem(
                child: Text("Search"),
                onTap: () {},
              )
            ])
          ],
          bottom: TabBar(
            tabs: [
              Padding(padding: EdgeInsets.symmetric(vertical: 13), child: Text("HOME")),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 13),
                child: Text("CALENDER"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 13),
                child: Text("MORE"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [JournalList(), CalenderScreen(), MoreScreen()],
        ),
      ),
    );
  }
}
