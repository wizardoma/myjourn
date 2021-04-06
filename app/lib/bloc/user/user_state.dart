import 'package:flutterfrontend/models/user.dart';

abstract class UserState {}

class UserNotInitializedState extends UserState {}

class UserFetchedState extends UserState {
  final User user;

  UserFetchedState(this.user);
}

class UserNullState extends UserState {}
