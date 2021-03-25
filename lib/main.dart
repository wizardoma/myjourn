import 'package:flutter/material.dart';
import 'package:flutterfrontend/providers/journal_provider.dart';
import 'package:flutterfrontend/screens/home/home_screen.dart';
import 'package:flutterfrontend/screens/journal/new_journal_screen.dart';
import 'package:flutterfrontend/screens/journal/view_journal_screen.dart';
import 'package:flutterfrontend/screens/search/search_screen.dart';
import 'package:flutterfrontend/screens/settings/settings_screen.dart';
import 'package:flutterfrontend/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: JournalProvider(),
      child: MaterialApp(
        title: "My Journal",
        debugShowCheckedModeBanner: false,
        theme: purpleTheme,
        routes: {
          NewJournalScreen.routeName: (context) => NewJournalScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          SearchScreen.routeName: (context) => SearchScreen(),
          SettingsScreen.routeName: (context) => SettingsScreen(),
          ViewJournalScreen.routeName: (context) => ViewJournalScreen(),
        },
        home: HomeScreen(),
      ),
    );
  }
}
