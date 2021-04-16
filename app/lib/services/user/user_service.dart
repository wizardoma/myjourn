import 'package:flutter/foundation.dart';
import 'package:flutterfrontend/models/user.dart';
import 'package:flutterfrontend/services/preferences/jwttoken_preferences.dart';
import 'package:flutterfrontend/services/preferences/user_preferences.dart';
import 'package:flutterfrontend/services/repository/server_const.dart';
import 'package:flutterfrontend/services/repository/user_repository.dart';
import 'package:flutterfrontend/util/response_utils.dart';

class UserService with ResponseUtil {
  static final AccessTokenPreferences _accessTokenPreferences =
      AccessTokenPreferences();
  static final UserPreferences _userPreferences = UserPreferences();
  final UserRepository userRepository;

  UserService({@required this.userRepository});

  Future<User> getCurrentUser() async {
    var token = await _accessTokenPreferences.getToken();
    Map<String, dynamic> headers = {
      "${ServerConstants.authHeaderName}":
          "${ServerConstants.tokenPrefix}$token"
    };
    var response = await userRepository.getCurrentUser(headers);

    if (isOk(response.statusCode)) {
      var user = User.fromMap(response.data);
      _userPreferences.setUser(user);
      return user;
    }
    // authentication
    else if (isAuthorizationError(response.statusCode)) {
      return null;
    }
  }

  Future<User> getCachedUser() async {
    return _userPreferences.getUser();
  }

  void deleteCachedUser() async{
    return _userPreferences.deleteUser();
  }
}
