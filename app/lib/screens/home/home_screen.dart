import 'package:flutter/material.dart';
import 'package:flutterfrontend/screens/calender/calender_screen.dart';
import 'package:flutterfrontend/screens/home/journal_list.dart';
import 'package:flutterfrontend/screens/more/more_screen.dart';
import 'package:flutterfrontend/screens/search/search_screen.dart';
import 'package:flutterfrontend/screens/settings/settings_screen.dart';
import 'package:flutterfrontend/ui_helpers.dart';

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
            onPressed: () {
              Navigator.of(context).pushNamed(SearchScreen.routeName);
            },
            icon: Icon(Icons.search),
          ),
          actions: [
            PopupMenuButton(
                padding: const EdgeInsets.all(0),
                onSelected: (_) {
                  Navigator.pushNamed(context, SettingsScreen.routeName);
                },
                itemBuilder: (context) {
                  return {"Setting"}.map((e) {
                    return PopupMenuItem(
                      child: Text(e),
                      value: e,
                    );
                  }).toList();
                })
          ],
          bottom: TabBar(
            tabs: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: defaultSpacing),
                  child: Text("HOME")),
              Padding(
                padding: EdgeInsets.symmetric(vertical: defaultSpacing),
                child: Text("CALENDER"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: defaultSpacing),
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
