import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app_flutter/model/dish_model.dart';
import 'package:test_app_flutter/view/widgets/dish_card.dart';
import '../../controller/cart_controller.dart';
import '../../controller/dishes_controller.dart';


class ScreenTwo extends StatelessWidget {
  final DishesController dishesController = Get.find();
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Dishes')),
      body: Obx(() {
        return ListView.builder(
          itemCount: dishesController.userDishes.length,
          itemBuilder: (context, index) {
            final Dish? dish = dishesController.userDishes[index];

            return DishCard(dish: dish);
          },
        );
      }),
    );
  }
}
