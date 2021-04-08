import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterfrontend/services/auth/login_request.dart';
import 'package:flutterfrontend/services/auth/signup_request.dart';
import 'package:flutterfrontend/services/auth/verify_email_request.dart';
import 'package:flutterfrontend/services/preferences/jwttoken_preferences.dart';
import 'package:flutterfrontend/services/repository/auth_repository.dart';
import 'package:flutterfrontend/services/repository/jsonresponse.dart';
import 'package:flutterfrontend/services/repository/server_const.dart';

class AuthenticationService {

  AuthenticationRepository authenticationRepository;
  static final AccessTokenPreferences _accessTokenPreferences = AccessTokenPreferences();

  AuthenticationService({@required this.authenticationRepository});

  Future<JsonResponse> login(LoginRequest loginRequest) async {
    var response = await authenticationRepository.login(FormData.fromMap(LoginRequest.toMap(loginRequest)));
    if (response.statusCode == 200){
      var token = _extractToken(response);
      _storeToken(token);
      print("The token is: "+token);
    }
    return response;
  }

  Future<JsonResponse> signUp(SignUpRequest signUpRequest) async {
    var response = await authenticationRepository.signUp(FormData.fromMap(SignUpRequest.toMap(signUpRequest)));
    if (response.statusCode == 201) {
      var token = _extractToken(response);
      _storeToken(token);
    }
    return response;
  }

    Future<String> getToken() async {
    String token = await _accessTokenPreferences.getToken();
    if (token == null || token.isEmpty) return null;
    return token;
  }

  Future<JsonResponse> verifyUniqueEmail(VerifyEmailRequest request) async{
    var response = await authenticationRepository.verifyUniqueEmail(FormData.fromMap({"email" : request.email.trim()}));
    return response;
  }

  String _extractToken(JsonResponse response){
    return response.headers.value(ServerConstants.authHeaderName).substring(ServerConstants.tokenPrefix.length);
  }

  void _storeToken(String token){
    _accessTokenPreferences.setToken(token);

  }

  Future<void> logout() async{
    _storeToken("");
  }


}