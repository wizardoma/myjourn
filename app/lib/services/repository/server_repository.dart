import 'package:dio/dio.dart';
import 'package:flutterfrontend/models/journal.dart';

class ServerRepository {
  static const _serverUrl= "http://myjournserver.herokuapp.com";
  static const _journal_url = "$_serverUrl/journals";

  Dio _dio;
  ServerRepository(){
    _dio = Dio();

  }

  Future<List<Journal>> getJournals() async {
    
}




}