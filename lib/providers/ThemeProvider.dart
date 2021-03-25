import 'package:flutter/material.dart';

import '../themes.dart';

class ThemeProvider with ChangeNotifier {
  Map<String, ThemeData> _themes;
  ThemeData _currentTheme = Themes.greenTheme;

  get themes {
    return _themes;
  }

  set themes(ThemeData theme) {
    this._currentTheme = theme;
    notifyListeners();
  }

  get currentTheme {
    return _currentTheme;
  }
}
