import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/journal/journal_bloc.dart';
import 'package:flutterfrontend/bloc/journal/journal_events.dart';
import 'package:flutterfrontend/bloc/search/search_journal_bloc.dart';
import 'package:flutterfrontend/bloc/settings/themes_bloc.dart';
import 'package:flutterfrontend/screens/auth/authentication_screen.dart';
import 'package:flutterfrontend/screens/auth/sign_in_screen.dart';
import 'package:flutterfrontend/screens/home/home_screen.dart';
import 'package:flutterfrontend/screens/journal/new_journal_screen.dart';
import 'package:flutterfrontend/screens/journal/view_journal_screen.dart';
import 'package:flutterfrontend/screens/search/search_screen.dart';
import 'package:flutterfrontend/screens/settings/settings_screen.dart';
import 'package:flutterfrontend/services/repository/journal_repository.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var repository = JournalRepository.instance;
  var themesBloc = ThemesBloc("green");
  await themesBloc.loadTheme();

  runApp(MyApp(repository, themesBloc));
}

class MyApp extends StatelessWidget {
  final ThemesBloc _themesBloc;
  final JournalRepository repository;

  MyApp(this.repository, this._themesBloc);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: JournalBloc()..add(FetchJournalsEvent()),
        ),
        BlocProvider(
          create: (context) => SearchJournalBloc(repository),
        ),
        BlocProvider.value(
          value: _themesBloc,
        ),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          title: "My Journal",
          debugShowCheckedModeBanner: false,
          theme: context.watch<ThemesBloc>().getCurrentTheme(),
          routes: {
            NewJournalScreen.routeName: (context) => NewJournalScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            AuthenticationScreen.routeName: (context) => AuthenticationScreen(),
            SignInScreen.routeName: (context) => SignInScreen(),
            SearchScreen.routeName: (context) => SearchScreen(),
            SettingsScreen.routeName: (context) => SettingsScreen(),
            ViewJournalScreen.routeName: (context) => ViewJournalScreen(),
          },
          home: AuthenticationScreen(),
        ),
      ),
    );
  }
}
