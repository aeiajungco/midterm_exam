import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const headers = {'Content-type': 'application/json'};

  Future<dynamic> login() {
    return http.post(Uri.parse(baseUrl + '/auth/login'));
  }
  // Future<bool> getAllCategories( ){
  //   return ;
  // }
}
