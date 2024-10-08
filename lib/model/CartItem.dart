import 'package:test_app_flutter/model/dish_model.dart';

class CartItem {
  int? id;
  int? quantity;
  Dish? dish;

  CartItem({
    this.id,
    this.quantity,
    this.dish,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      quantity: json['quantity'],
      dish: Dish.fromJson(json["dish"]),
    );
  }
}
