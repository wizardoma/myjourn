import 'package:flutter/material.dart';
import 'package:flutterfrontend/screens/home/home_screen.dart';
import 'package:flutterfrontend/screens/journal/new_journal_screen.dart';
import 'package:flutterfrontend/screens/search/search_screen.dart';
import 'package:flutterfrontend/screens/settings/settings_screen.dart';
import 'package:flutterfrontend/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Journal",
      debugShowCheckedModeBanner: false,
      theme: theme,
      routes: {
        NewJournalScreen.routeName: (context) => NewJournalScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        SearchScreen.routeName: (context) => SearchScreen(),
        SettingsScreen.routeName: (context) => SettingsScreen(),
      },
      home: HomeScreen(),
    );
  }
}
