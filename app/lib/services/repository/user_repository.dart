import 'package:dio/dio.dart';
import 'package:flutterfrontend/services/repository/jsonresponse.dart';
import 'package:flutterfrontend/services/repository/server_const.dart';

class UserRepository {

  static final Dio _dio = Dio();

  UserRepository._private();
  static final UserRepository _instance = UserRepository._private();

  factory UserRepository() {
    return _instance;
  }

  Future<JsonResponse> getCurrentUser(Map<String, dynamic> headers) async {
    Response response;
    try {
      response = await _dio.get(ServerConstants.userUrl,
          options: Options(headers: headers));
      return JsonResponse.fromResponse(response);
    }
    on DioError catch(e) {
      return JsonResponse.fromResponse(e.response);
    }

  }
}