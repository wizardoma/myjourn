import 'package:dio/dio.dart';
import 'package:flutterfrontend/services/repository/jsonresponse.dart';

import 'server_const.dart';

class AuthenticationRepository {
  Dio _dio;

  AuthenticationRepository() {
    _dio = Dio();
  }

  Future<JsonResponse> login(FormData loginRequest) async {
    try {
      var response =
          await _dio.post(ServerConstants.loginUrl, data: loginRequest);
      print("response: ${response.data.toString()}");
      return JsonResponse.fromResponse(response);
    } on DioError catch (e) {
      print(e.message);
      return JsonResponse.fromResponse(e.response);
    }
  }

  Future<JsonResponse> signUp(FormData signUpCreds) async {
    var response =
        await _dio.post(ServerConstants.signUpUrl, data: signUpCreds);
    return JsonResponse.fromResponse(response);
  }

  Future<JsonResponse> verifyUniqueEmail(
      FormData verifyCreds) async {
    Response response;
    print("verifying email: ${verifyCreds.fields}");
    try {
      response =
          await _dio.post(ServerConstants.authUrl, data: verifyCreds);
      print(response.data);

      return JsonResponse.fromResponse(response);
    } on DioError catch (e) {
      print(e.response.data);

      return JsonResponse.fromResponse(e.response);
    }
  }
}
