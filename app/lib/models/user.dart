import 'package:flutter/foundation.dart';

class User {
  int _id;
  String _email;
  String _username;
  String _password;

  User({
    @required int id,
    @required String email,
    @required String username,
    @required String password,
  })  : _id = id,
        _email = email,
        _username = username,
        _password = password;

  factory User.fromMap(Map<String, dynamic> map) {
    return new User(
      id: map['_id'] as int,
      email: map['_email'] as String,
      username: map['_username'] as String,
      password: map['_password'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      '_id': this._id,
      '_email': this._email,
      '_username': this._username,
      '_password': this._password,
    } as Map<String, dynamic>;
  }
}
