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
      '_id': this._id,
      '_email': this._email,
      '_username': this._username,
    } as Map<String, dynamic>;
  }
}
