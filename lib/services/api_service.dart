import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart.dart';
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
      var products = <Product>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        for (var item in jsonData) {
          products.add(Product.fromJson(item));
        }
      }
      return products;
    }).catchError((error) => print(error));
  }

  Future<Product> getProduct(int id) {
    return http
        .get(Uri.parse('$api/products/$id'), headers: headers)
        .then((data) {
      var jsonData;
      if (data.statusCode == 200) {
        jsonData = json.decode(data.body);
      }
      return Product.fromJson(jsonData);
    }).catchError((error) => print(error));
  }

  Future<dynamic> getAllCategories() {
    return http
        .get(Uri.parse('$api/products/categories'), headers: headers)
        .then((data) {
      var categories = [];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        for (var item in jsonData) {
          categories.add(item);
        }
      }
      return categories;
    }).catchError((error) => print(error));
  }

  Future<List<Product>> getProductsByCategory(String categoryname) {
    return http
        .get(Uri.parse('$api/products/category/$categoryname'),
            headers: headers)
        .then((data) {
      var products = <Product>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        for (var item in jsonData) {
          products.add(Product.fromJson(item));
        }
      }
      return products;
    }).catchError((error) => print(error));
  }

  // Future<Cart> updateCart(int userId, int id) {
  //   return http.put(Uri.parse('$api/products/$id'), headers: headers, body: {

  //   })
  // }

  // Future<bool> getAllCategories( ){
  //   return ;
  // }
}
