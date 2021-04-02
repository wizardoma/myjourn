import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/journal_bloc.dart';
import 'package:flutterfrontend/bloc/search_journal_bloc.dart';
import 'package:flutterfrontend/providers/ThemeProvider.dart';
import 'package:flutterfrontend/providers/journal_provider.dart';
import 'package:flutterfrontend/screens/home/home_screen.dart';
import 'package:flutterfrontend/screens/journal/new_journal_screen.dart';
import 'package:flutterfrontend/screens/journal/view_journal_screen.dart';
import 'package:flutterfrontend/screens/search/search_screen.dart';
import 'package:flutterfrontend/screens/settings/settings_screen.dart';
import 'package:flutterfrontend/services/repository/journal_repository.dart';
import 'package:provider/provider.dart';

import 'bloc/journal_events.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var repository = JournalRepository.instance;
  runApp(MyApp(repository));
}

class MyApp extends StatelessWidget {
  final JournalRepository repository;

  MyApp(this.repository);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: JournalProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      builder: (context, child) {
        var themeProvider = Provider.of<ThemeProvider>(context);
        return FutureBuilder(
          future: themeProvider.loadTheme(),
          builder: (context, AsyncSnapshot<String> data) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (ctx) =>
                    JournalBloc()..add(FetchJournalsEvent()),
              ),
              BlocProvider(
                create: (context) => SearchJournalBloc(repository),
              ),
            ],
            child: MaterialApp(
              title: "My Journal",
              debugShowCheckedModeBanner: false,
              theme: themeProvider.currentThemeData,
              routes: {
                NewJournalScreen.routeName: (context) => NewJournalScreen(),
                HomeScreen.routeName: (context) => HomeScreen(),
                SearchScreen.routeName: (context) => SearchScreen(),
                SettingsScreen.routeName: (context) => SettingsScreen(),
                ViewJournalScreen.routeName: (context) => ViewJournalScreen(),
              },
              home: HomeScreen(),
            ),
          ),
        );
      },
    );
  }
}
