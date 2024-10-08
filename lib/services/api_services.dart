import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:test_app_flutter/constants/string_constants.dart';
import 'package:test_app_flutter/model/CartItem.dart';
import 'dart:convert';

import '../model/dish_model.dart';

class ApiService {
  Future<List<Dish>> fetchRecommendedDishes() async {
    final response = await http.get(
      Uri.parse(
          '${StringConstants.baseUrl}without-login/masters/all-recommended-dishes'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final Iterable dishesData = jsonData['data'];

      var dataList =
          dishesData.map((dynamic element) => Dish.fromJson(element)).toList();

      return dataList;
    } else {
      throw Exception('Failed to load recommended dishes');
    }
  }

  static Future<List<Dish>> fetchUserDishes() async {
    final response = await http.get(
      Uri.parse('${StringConstants.baseUrl}/user/restaurants/dishes'),
      headers: {'Authorization': 'Bearer ${StringConstants.token}'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Dish.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load dishes');
    }
  }

  static Future<void> updateCartQuantity(
      int dishId, int restaurantId, String type) async {
    final body = json.encode({
      'restaurent_id': restaurantId,
      'dishe_id': dishId,
      'type': type,
    });

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': StringConstants.token
    };

    final response = await http.post(
      Uri.parse('${StringConstants.baseUrl}user/cart/quantity'),
      headers: headers,
      body: body,
    );

    debugPrint("response.body : ${response.body}");

    final jsonData = json.decode(response.body);

    if (response.statusCode != 200 || jsonData['code'] != 200) {
      throw Exception('Failed to update cart quantity');
    }
  }

   Future<List<CartItem>> fetchCart() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': StringConstants.token
    };

    final response = await http.get(
      Uri.parse('${StringConstants.baseUrl}user/cart'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // debugPrint("jsonData: $jsonData");

      Iterable data = jsonData['data'][0]['cart_details'];

      // debugPrint("data: $data");

      final list = data.map((element) => CartItem.fromJson(element)).toList();
      debugPrint("list; $list");

      return list;
    } else {
      throw Exception('Failed to load cart');
    }
  }
}
