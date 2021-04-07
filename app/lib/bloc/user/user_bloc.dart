
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
    });
  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) async*{
//    if (this.state is UserNotInitializedState){
//      yield await fetchUser();
//    }
    if (event is FetchUserEvent){
      yield await fetchUser();
    }
  }

  Future<UserState> fetchUser() async {
    var user = await userService.getCurrentUser();
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
    if (user!=null) {return user;}
    else {
      var userState = await fetchUser();
      if (userState is UserFetchedState){
       user =  userState.user;
      }
    }
    print(user);

    return user;
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}