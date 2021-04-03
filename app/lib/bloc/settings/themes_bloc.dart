import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/services/preferences/theme_preferences.dart';
import 'package:flutterfrontend/themes.dart';

class ThemesBloc extends Cubit<String> {
  Map<String, ThemeData> _themes = Themes.getThemes();
  String _themeName;

  ThemesBloc(String defaultTheme) : super(defaultTheme);

  get themes { return _themes;}

  String get currentTheme { return _themeName;}

  void setTheme(String themeName) {
    ThemePreferences().setAppTheme(themeName);
    this._themeName = themeName;
    emit(_themeName);
  }

  ThemeData getCurrentTheme() {
    return _themes[_themeName];
}

  Future<String> loadTheme() async {

    var themeName = await ThemePreferences().getAppTheme();
    this._themeName = themeName;
    emit(_themeName);
    return themeName;
  }
}