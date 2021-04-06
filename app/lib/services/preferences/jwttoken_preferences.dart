import 'package:shared_preferences/shared_preferences.dart';

class AccessTokenPreferences {
  static const _appThemePrefName = "token";

  setToken(String themeName) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(_appThemePrefName, themeName);
  }

  Future<String> getToken() async {
    var preferences = await SharedPreferences.getInstance();
    return preferences.get(_appThemePrefName);
  }
}