
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/auth/auth_bloc.dart';
import 'package:flutterfrontend/bloc/auth/authentication_event.dart';
import 'package:flutterfrontend/bloc/auth/authentication_state.dart';
import 'package:flutterfrontend/bloc/user/user_event.dart';
import 'package:flutterfrontend/bloc/user/user_state.dart';
import 'package:flutterfrontend/models/user.dart';
import 'package:flutterfrontend/services/user/user_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthenticationBloc authenticationBloc;
  final UserService userService;
  StreamSubscription _streamSubscription;
  UserBloc({this.authenticationBloc, this.userService}) : super(UserNotInitializedState()){
    _streamSubscription = authenticationBloc.stream.listen((state) {
      if (state is IsAuthenticated){
        print("from users now going to fetch user");
        this.add(FetchUserEvent());
      }
      if (state is NotAuthenticated){
        deleteCachedUser();
//        this.add(ClearUserEvent());
      }
    });
  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) async*{
//    if (this.state is UserNotInitializedState){
//      yield await fetchUser();
//    }
    if (event is FetchUserEvent){
      print("it is fetch user event");
      yield await fetchUser();
    }

//    if (event is ClearUserEvent){
//      yield await
//    }
  }

  Future<UserState> fetchUser() async {
    User user;
    user = await fetchCachedUser();
    if (user != null) return UserFetchedState(user);

    user = await userService.getCurrentUser();
    if (user== null) {
      authenticationBloc.add(LogoutEvent());
      return UserNullState();
    }
    else {
      return UserFetchedState(user);
    }
  }

  Future<User> fetchCachedUser() async {
    User user;
    user = await userService.getCachedUser();
    return user;
  }

  Future<void> deleteCachedUser() async {
    userService.deleteCachedUser();
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}