import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {

  static const _appThemePrefName = "AppTheme";

  setAppTheme(String themeName) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(_appThemePrefName, themeName);
  }

  Future<String> getAppTheme() async {
    var preferences = await SharedPreferences.getInstance();
    return preferences.get(_appThemePrefName) ?? "green";
  }


}