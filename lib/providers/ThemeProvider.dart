import 'package:flutter/material.dart';
import 'package:flutterfrontend/services/preferences/theme_preferences.dart';

import '../themes.dart';

class ThemeProvider with ChangeNotifier {
  Map<String, ThemeData> _themes = Themes.getThemes();
  String themeName = "green";

  Map<String, ThemeData> get themes {
    return _themes;
  }

  get currentThemeData  {
    return _themes[themeName];
  }

  set theme(String themeName) {
    print("Saving themeName : $themeName");
    ThemePreferences().setAppTheme(themeName);
    this.themeName = themeName;
    notifyListeners();
  }

  Future<String> get currentTheme async{
    var themeName = await ThemePreferences().getAppTheme();
    return themeName;
  }
}
