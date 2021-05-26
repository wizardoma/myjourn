import 'package:flutter/material.dart';
import 'package:flutterfrontend/screens/calender/calender_screen.dart';
import 'package:flutterfrontend/screens/home/journal_list.dart';
import 'package:flutterfrontend/screens/more/more_screen.dart';
import 'package:flutterfrontend/screens/search/search_screen.dart';
import 'package:flutterfrontend/screens/settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(

          title: Center(
            child: Text("MYJOURN"),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SearchScreen.routeName);
            },
            icon: Icon(Icons.search),
          ),
          actions: [
            PopupMenuButton(
                padding: EdgeInsets.all(0),
                onSelected: (_) {
                  Navigator.pushNamed(context, SettingsScreen.routeName);
                },
                itemBuilder: (context) {
                  return {"Setting"}.map((e) {
                    return PopupMenuItem(
                      textStyle: Theme.of(context).textTheme.headline1,
                      child: Text(e),
                      value: e,
                    );
                  }).toList();
                })
          ],
          bottom: TabBar(
            tabs: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 13),
                  child: Text("HOME")),
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
          children: [
            JournalList(),
            CalenderScreen(),
            MoreScreen(),
          ],
        ),
      ),
    );
  }
}
