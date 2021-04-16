import 'package:dio/dio.dart';
import 'package:flutterfrontend/services/repository/jsonresponse.dart';

import 'server_const.dart';

class AuthenticationRepository {
  static final Dio _dio = Dio();

  AuthenticationRepository._privateConstructor();

  static final AuthenticationRepository _instance = AuthenticationRepository._privateConstructor();

  factory AuthenticationRepository() {
    return _instance;
  }
  Future<JsonResponse> login(FormData loginRequest) async {
    try {
      var response =
          await _dio.post(ServerConstants.loginUrl, data: loginRequest);
      return JsonResponse.fromResponse(response);
    } on DioError catch (e) {
      return JsonResponse.fromResponse(e.response);
    }
  }

  Future<JsonResponse> signUp(FormData signUpCreds) async {
    Response response;
    try {
      response =
      await _dio.post(ServerConstants.signUpUrl, data: signUpCreds);
    return JsonResponse.fromResponse(response);
  }
  on DioError catch (e) {
      return JsonResponse.fromResponse(e.response);
  }
  catch (e) {
      print(e);
  }

  }

  Future<JsonResponse> verifyUniqueEmail(
      FormData verifyCreds) async {
    Response response;
    try {
      response =
          await _dio.post(ServerConstants.authUrl, data: verifyCreds);

      return JsonResponse.fromResponse(response);
    } on DioError catch (e) {

      return JsonResponse.fromResponse(e.response);
    }
  }
}
