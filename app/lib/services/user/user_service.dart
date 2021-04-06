import 'package:flutterfrontend/models/user.dart';
import 'package:flutterfrontend/services/preferences/jwttoken_preferences.dart';
import 'package:flutterfrontend/services/repository/server_const.dart';
import 'package:flutterfrontend/services/repository/user_repository.dart';
import 'package:flutterfrontend/util/response_utils.dart';

class UserService with ResponseUtil{
  static final AccessTokenPreferences _accessTokenPreferences = AccessTokenPreferences();
  UserRepository _userRepository;

  UserService(){
    _userRepository = UserRepository();
  }

  Future<User> getCurrentUser() async{
    var token = await _accessTokenPreferences.getToken();
    Map<String, dynamic> headers = {"${ServerConstants.authHeaderName}": "${ServerConstants.tokenPrefix}$token"};
    var response = await _userRepository.getCurrentUser(headers);

    if (ResponseUtil.isOk(response.statusCode)){
      return User.fromMap(response.data);
    }
    // authentication
    else if (ResponseUtil.isAuthorizationError(response.statusCode)){
      return null;
    }


  }

}