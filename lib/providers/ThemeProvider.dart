import 'package:flutter/material.dart';

import '../themes.dart';

class ThemeProvider with ChangeNotifier {
  Map<String, ThemeData> _themes = Themes.getThemes();
  ThemeData _currentTheme = Themes.greenTheme;

  Map<String, ThemeData> get themes {
    return _themes;
  }

  set theme(ThemeData theme) {
    this._currentTheme = theme;
    notifyListeners();
  }

  get currentTheme {
    return _currentTheme;
  }
}
