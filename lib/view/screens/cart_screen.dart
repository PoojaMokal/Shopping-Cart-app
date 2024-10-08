// screens/screen_one.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app_flutter/controller/cart_controller.dart';
import 'package:test_app_flutter/model/CartItem.dart';
import 'package:test_app_flutter/model/dish_model.dart';
import 'package:test_app_flutter/services/api_services.dart';
import 'package:test_app_flutter/view/widgets/dish_card.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  final CartController cartController = Get.find<CartController>();
  final ApiService apiService = ApiService();
  bool isLoading = true;
  List<CartItem> recommendedDishes = [];


  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  Future<void> fetchCart() async {
    debugPrint("inside fetch cart");

    try {
      final List<CartItem> dishes = await apiService.fetchCart();
      debugPrint("dishes: $dishes");

      setState(() {
        recommendedDishes = dishes;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle the error accordingly, such as showing a Snackbar
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : recommendedDishes.isEmpty
          ? Center(child: Text('Cart is empty'))
          : ListView.builder(
        itemCount: recommendedDishes.length,
        itemBuilder: (context, index) {
          final Dish? dish = recommendedDishes[index].dish;

          return DishCard(dish: dish);
        },
      ),
    );
  }
}
