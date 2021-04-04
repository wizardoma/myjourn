import 'package:dio/dio.dart';

class JsonResponse<T> {
  final int statusCode;
  final Headers headers;
  final T data;
  final Map<String, String> errors;

  JsonResponse(this.statusCode, this.data, this.errors, this.headers);

  factory JsonResponse.fromResponse(Response response) {
    return JsonResponse(response.data["status"], response.data["body"], response.data["errors"], response.headers);
  }

  factory JsonResponse.withData(Response response) {
    return JsonResponse(response.data["status"], response.data["body"], null, response.headers);
  }

  factory JsonResponse.withError(Response response) {
    return JsonResponse(response.data["status"], null, response.data["errors"],  response.headers);
  }
}