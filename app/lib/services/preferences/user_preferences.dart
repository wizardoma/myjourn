import 'dart:convert';

import 'package:flutterfrontend/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String prefName = "user";

  setUser(User user) async {
    var instance = await SharedPreferences.getInstance();
    var encodedUser = jsonEncode(user.toMap());
    await instance.setString(prefName, encodedUser);
  }

  Future<User> getUser() async {
    var instance = await SharedPreferences.getInstance();
    var userObj = instance.get(prefName);
    if (userObj == null || (userObj as String).isEmpty) return null;
    print("$userObj");
    var user = User.fromMap(jsonDecode(userObj));
    return user;
  }

  void deleteUser() async {
    var instance = await SharedPreferences.getInstance();
    instance.setString(prefName, "");
  }
}
