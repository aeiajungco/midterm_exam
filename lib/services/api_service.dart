import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_response.dart';
import '../models/product.dart';

class ApiService {
  static const String api = 'https://fakestoreapi.com';
  static const headers = {'Content-type': 'application/json'};

  Future<dynamic> login(String username, String password) {
    return http.post(Uri.parse('$api/auth/login'),
        body: {'username': username, 'password': password}).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return jsonData;
        // return Future<dynamic>(jsonData);
      }
    }).catchError((error) => print(error));
  }

  Future<List<Product>> getAllProducts() {
    return http.get(Uri.parse('$api/products'), headers: headers).then((data) {
      final products = <Product>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        for (var item in jsonData) {
          products.add(Product.fromJson(item));
        }
      }
      return products;
    }).catchError((error) => print(error));
  }

  
  // Future<bool> getAllCategories( ){
  //   return ;
  // }
}
