import 'dart:convert';

import 'package:flutterfrontend/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String prefName = "user";

  setUser(User user) async {
    var instance = await SharedPreferences.getInstance();
    var encodedUser = jsonEncode(user.toMap());
    print("inserted user to pref $encodedUser");
    await instance.setString(prefName, encodedUser);
  }

  Future<User> getUser() async {
    var instance = await SharedPreferences.getInstance();
    var user = User.fromMap(jsonDecode(instance.get(prefName)));
    print("Gotten user from pref ${user.toMap()}");

    return user;
  }
}
