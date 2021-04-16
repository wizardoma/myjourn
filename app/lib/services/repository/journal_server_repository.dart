import 'package:dio/dio.dart';
import 'package:flutterfrontend/services/repository/jsonresponse.dart';
import 'package:flutterfrontend/services/repository/server_const.dart';

class JournalServerRepository {
  static final Dio _dio = Dio();

  Future<JsonResponse> save(FormData data, Map<String, dynamic> headers) async {
    Response response;
    try {
      response = await _dio.post(ServerConstants.journalsUrl,
          data: data, options: Options(headers: headers));
      return JsonResponse.fromResponse(response);
    } on DioError catch (e) {

      return JsonResponse.fromResponse(e.response);
    }
  }

  Future<JsonResponse> getAll(Map<String, dynamic> headers) async {
    Response response;
    try {
      response = await _dio.get(ServerConstants.journalsUrl,
          options: Options(headers: headers));
      return JsonResponse.fromResponse(response);
    } on DioError catch (e) {

      return JsonResponse.fromResponse(e.response);
    }
  }

  Future<JsonResponse> edit(
      int dbId, FormData request, Map<String, dynamic> headers) async {
    Response response;
    try {
      response = await _dio.patch("${ServerConstants.journalsUrl}/$dbId",
          data: request, options: Options(headers: headers));

      return JsonResponse.fromResponse(response);
    } on DioError catch (e) {

      return JsonResponse.fromResponse(e.response);
    }
  }

  Future<JsonResponse> delete(
      int dbId, Map<String, dynamic> headers) async {
    Response response;
    try {
      response = await _dio.delete("${ServerConstants.journalsUrl}/$dbId",
          options: Options(headers: headers));
      return JsonResponse.fromResponse(response);
    } on DioError catch (e) {

      return JsonResponse.fromResponse(e.response);
    }
  }
}
