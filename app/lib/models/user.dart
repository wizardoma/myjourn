import 'package:flutter/foundation.dart';

class User {
  int _id;
  String _email;
  String _username;

  User({
    @required int id,
    @required String email,
    @required String username,
  })  : _id = id,
        _email = email,
        _username = username;

  int get id => _id;

  factory User.fromMap(Map<String, dynamic> map) {
    return new User(
      id: map['id'] as int,
      email: map['email'] as String,
      username: map['username'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this._id,
      'email': this._email,
      'username': this._username,
    } as Map<String, dynamic>;
  }

  String get email => _email;

  String get username => _username;
}
