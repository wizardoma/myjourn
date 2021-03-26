import 'package:flutter/material.dart';
import 'package:flutterfrontend/services/preferences/theme_preferences.dart';

import '../themes.dart';

class ThemeProvider with ChangeNotifier {
  Map<String, ThemeData> _themes = Themes.getThemes();
  String themeName;

  Map<String, ThemeData> get themes {
    return _themes;
  }

  get currentThemeData  {
    return _themes[themeName];
  }

  set theme(String themeName) {
    ThemePreferences().setAppTheme(themeName);
    this.themeName = themeName;
    notifyListeners();
  }

  String get currentTheme{
    return themeName;
  }

  Future<String> loadTheme() async {
    var themeName = await ThemePreferences().getAppTheme();
    this.themeName = themeName;
    return themeName;
  }
}
