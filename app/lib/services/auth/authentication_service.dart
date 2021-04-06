import 'package:dio/dio.dart';
import 'package:flutterfrontend/services/auth/login_request.dart';
import 'package:flutterfrontend/services/auth/signup_request.dart';
import 'package:flutterfrontend/services/auth/verify_email_request.dart';
import 'package:flutterfrontend/services/preferences/authentication_preferences.dart';
import 'package:flutterfrontend/services/repository/auth_repository.dart';
import 'package:flutterfrontend/services/repository/jsonresponse.dart';
import 'package:flutterfrontend/services/repository/server_const.dart';

class AuthenticationService {

  Future<JsonResponse> login(LoginRequest loginRequest) async {
    var response = await AuthenticationRepository().login(FormData.fromMap(LoginRequest.toMap(loginRequest)));
    if (response.statusCode == 200){
      var token = _extractToken(response);
      _storeToken(token);
      print("The token is: "+token);
    }
    return response;
  }

  Future<JsonResponse> signUp(SignUpRequest signUpRequest) async {
    var response = await AuthenticationRepository().signUp(FormData.fromMap(SignUpRequest.toMap(signUpRequest)));
    if (response.statusCode == 201) {
      var token = _extractToken(response);
      _storeToken(token);
      print("the token is: $token");
    }
    return response;
  }

  static Future<bool> isAuthenticated() async {
    String token = await AuthenticationPreferences().getToken();
    print("isAuthenticated $token");
    if (token == null || token.isEmpty) return false;
    return true;
  }

  Future<JsonResponse> verifyUniqueEmail(VerifyEmailRequest request) async{
    var response = await AuthenticationRepository().verifyUniqueEmail(FormData.fromMap({"email" : request.email.trim()}));
    print("Gotten response : ${response.errors}");
    return response;
  }

  String _extractToken(JsonResponse response){
    return response.headers.value(ServerConstants.authHeaderName).substring(ServerConstants.tokenPrefix.length);
  }

  void _storeToken(String token){
    AuthenticationPreferences().setToken(token);

  }

  Future<void> logout() async{
    _storeToken("");
  }


}