import 'package:dio/dio.dart';

class JsonResponse<T> {
  final int statusCode;
  final Headers headers;
  final T data;
  final Map<String, dynamic> errors;

  JsonResponse(this.statusCode, this.data, this.errors, this.headers);

  factory JsonResponse.fromResponse(Response response) {
//    print("response from map ${response.data["body"].toString()}");
    JsonResponse jsonResponse;
    try {
      jsonResponse = JsonResponse(response.data["status"], response.data["body"], response.data["errors"], response.headers);
    return jsonResponse; }
    catch (e) {
      return JsonResponse(response.statusCode, null, null, response.headers);
    }

  }

  factory JsonResponse.withData(Response response) {
    return JsonResponse(int.parse(response.data["status"]), response.data["body"], null, response.headers);
  }

  factory JsonResponse.withError(Response response) {
    return JsonResponse(int.parse(response.data["status"]), null, response.data["errors"],  response.headers);
  }
}