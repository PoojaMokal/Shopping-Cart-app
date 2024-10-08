// screens/screen_one.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app_flutter/controller/cart_controller.dart';
import 'package:test_app_flutter/model/dish_model.dart';
import 'package:test_app_flutter/services/api_services.dart';
import 'package:test_app_flutter/view/screens/cart_screen.dart';
import 'package:test_app_flutter/view/widgets/dish_card.dart';

class ScreenOne extends StatefulWidget {
  @override
  _ScreenOneState createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  final CartController cartController = Get.find<CartController>();
  final ApiService apiService = ApiService();
  List<Dish> recommendedDishes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecommendedDishes();
    apiService.fetchCart();
  }

  Future<void> fetchRecommendedDishes() async {
    try {
      final dishes = await apiService.fetchRecommendedDishes();
      // debugPrint("dishes: $dishes");

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
      appBar: AppBar(
        title: Text('Recommended Dishes'),
        actions: [
          Obx(() {
            return Badge(
              child: IconButton(
                onPressed: () {
                  Get.to(() => CartScreen());
                },
                icon: Icon(Icons.shopping_cart),),
              label: Text("${cartController.cartItems.length}"),
            );
          },),
          SizedBox(width: 20,),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : recommendedDishes.isEmpty
              ? Center(child: Text('No dishes available'))
              : ListView.builder(
                  itemCount: recommendedDishes.length,
                  itemBuilder: (context, index) {
                    final Dish? dish = recommendedDishes[index];

                    return DishCard(dish: dish);
                  },
                ),
    );
  }
}
