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

  Future<Cart> getCart(String userId) {
    return http
        .get(Uri.parse('$api/carts/$userId'), headers: headers)
        .then((data) {
      var cart = Cart();
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        cart = Cart.fromJson(jsonData);
      }
      return cart;
    });
  }

  Future<bool> deleteFromCart(String id) {
    return http
        .delete(Uri.parse('$api/carts/$id'), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        print(data.body);
      }
      return true;
    }).catchError((error) => print(error));
  }

  Future<bool> updateCart(int id, int prodId) {
    final update = Cart(userId: id, date: DateTime.now(), products: [
      {'productId': prodId, 'quantity': 1}
    ]);

    return http
        .put(Uri.parse('$api/carts/$id'),
            headers: headers, body: json.encode(update.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print(jsonData);
      }
      return true;
    }).catchError((error) => print(error));
  }
}
