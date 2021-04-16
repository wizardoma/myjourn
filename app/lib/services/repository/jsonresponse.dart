import 'package:dio/dio.dart';

class JsonResponse<T> {
  final int statusCode;
  final Headers headers;
  final T data;
  final Map<String, dynamic> errors;

  JsonResponse(this.statusCode, this.data, this.errors, this.headers);

  factory JsonResponse.fromResponse(Response response) {
    JsonResponse jsonResponse;
    try {
      jsonResponse = JsonResponse(response.data["status"], response.data["body"], response.data["errors"], response.headers);
    return jsonResponse; }
    catch (e) {
      return JsonResponse(response.statusCode, null, null, response.headers);
    }

  }

}