import 'package:dio/dio.dart';
import 'package:flutterfrontend/services/repository/jsonresponse.dart';

import 'server_const.dart';

class AuthenticationRepository {
  Dio _dio;
  AuthenticationRepository(){
    _dio = Dio();
  }

  Future<JsonResponse> login(Map<String, dynamic> loginRequest) async{
    var response = await _dio.post(ServerConstants.loginUrl, data: loginRequest);
    return JsonResponse.fromResponse(response);
  }

  Future<JsonResponse> signUp(Map<String, dynamic> signUpCreds) async {
    var response = await _dio.post(ServerConstants.signUpUrl, data: signUpCreds);
    return JsonResponse.fromResponse(response);
  }

}