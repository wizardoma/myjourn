import 'package:flutterfrontend/services/auth/login_creds.dart';
import 'package:flutterfrontend/services/auth/signup_creds.dart';
import 'package:flutterfrontend/services/preferences/authentication_preferences.dart';
import 'package:flutterfrontend/services/repository/auth_repository.dart';
import 'package:flutterfrontend/services/repository/jsonresponse.dart';
import 'package:flutterfrontend/services/repository/server_const.dart';

class AuthenticationService {

  Future<JsonResponse> login(LoginRequest loginRequest) async {
    var response = await AuthenticationRepository().login(LoginRequest.toMap(loginRequest));
    if (response.statusCode == 200){
      var token = _extractToken(response);
      _storeToken(token);
      print("The token is: "+token);
      return JsonResponse.withData(response.data);
    }
    else return JsonResponse.withError(response.data);
  }

  Future<JsonResponse> signUp(SignUpRequest signUpRequest) async {
    var response = await AuthenticationRepository().signUp(SignUpRequest.toMap(signUpRequest));
    if (response.statusCode == 201) {
      var token  = _extractToken(response);
      _storeToken(token);
      print("the token is: $token");
      return JsonResponse.withData(response.data);
    }
    else return JsonResponse.withError(response.data);
  }

  String _extractToken(JsonResponse response){
    return response.headers.value(ServerConstants.authHeaderName).substring(0, ServerConstants.tokenPrefix.length);
  }

  void _storeToken(String token){
    AuthenticationPreferences().setToken(token);

  }

  Future<void> logout() async{
    _storeToken(null);
  }
}