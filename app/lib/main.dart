import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/auth/auth_bloc.dart';
import 'package:flutterfrontend/bloc/auth/authentication_event.dart';
import 'package:flutterfrontend/bloc/auth/authentication_state.dart';
import 'package:flutterfrontend/bloc/journal/journal_bloc.dart';
import 'package:flutterfrontend/bloc/journal/journal_events.dart';
import 'package:flutterfrontend/bloc/search/search_journal_bloc.dart';
import 'package:flutterfrontend/bloc/settings/themes_bloc.dart';
import 'package:flutterfrontend/bloc/user/user_bloc.dart';
import 'package:flutterfrontend/screens/auth/authentication_screen.dart';
import 'package:flutterfrontend/screens/auth/sign_in_screen.dart';
import 'package:flutterfrontend/screens/home/home_screen.dart';
import 'package:flutterfrontend/screens/journal/new_journal_screen.dart';
import 'package:flutterfrontend/screens/journal/view_journal_screen.dart';
import 'package:flutterfrontend/screens/search/search_screen.dart';
import 'package:flutterfrontend/screens/settings/settings_screen.dart';
import 'package:flutterfrontend/services/auth/authentication_service.dart';
import 'package:flutterfrontend/services/repository/journal_repository.dart';
import 'package:flutterfrontend/services/user/user_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var repository = JournalRepository.instance;
  var userService = UserService();

  var authenticationService = AuthenticationService();
  var authenticationBloc =
      AuthenticationBloc(authenticationService: authenticationService)
        ..add(AppStartedEvent());
  var journalBloc = JournalBloc(repository)..add(FetchJournalsEvent());
  var userBloc = UserBloc(
      authenticationBloc: authenticationBloc, userService: userService);
  var themesBloc = ThemesBloc("green");
  await themesBloc.loadTheme();

  runApp(MyApp(authenticationBloc, journalBloc, userBloc, themesBloc));
}

class MyApp extends StatelessWidget {
  final ThemesBloc _themesBloc;
  final JournalBloc _journalBloc;
  final UserBloc _userBloc;
  final AuthenticationBloc _authenticationBloc;

  MyApp(this._authenticationBloc, this._journalBloc, this._userBloc,
      this._themesBloc);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _authenticationBloc),
        BlocProvider.value(
          value: _journalBloc,
        ),
        BlocProvider(
          create: (context) => SearchJournalBloc(
              journalBloc: BlocProvider.of<JournalBloc>(context)),
        ),
        BlocProvider.value(
          value: _themesBloc,
        ),
        BlocProvider.value(value: _userBloc)
      ],
      child: Builder(
        builder: (context) =>
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) => MaterialApp(
            title: "My Journal",
            debugShowCheckedModeBanner: false,
            theme: context.watch<ThemesBloc>().getCurrentTheme(),
            routes: {
              NewJournalScreen.routeName: (context) => NewJournalScreen(),
              HomeScreen.routeName: (context) => HomeScreen(),
              AuthenticationScreen.routeName: (context) =>
                  AuthenticationScreen(),
              SignInScreen.routeName: (context) => SignInScreen(),
              SearchScreen.routeName: (context) => SearchScreen(),
              SettingsScreen.routeName: (context) => SettingsScreen(),
              ViewJournalScreen.routeName: (context) => ViewJournalScreen(),
            },
            home: state is IsAuthenticated
                ? HomeScreen()
                : AuthenticationScreen(),
          ),
        ),
      ),
    );
  }
}
