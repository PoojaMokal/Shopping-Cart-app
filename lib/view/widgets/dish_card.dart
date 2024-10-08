import 'package:flutter/material.dart';
import 'package:test_app_flutter/controller/cart_controller.dart';
import 'package:test_app_flutter/model/CartItem.dart';
import 'package:test_app_flutter/model/dish_model.dart';
import 'package:get/get.dart';

class DishCard extends StatelessWidget {
  final Dish? dish;
  const DishCard({super.key, this.dish});

  @override
  Widget build(BuildContext context) {
    // final element = cartController.cartItems.where((e) => e?.dish?.id == dish?.id).toList().first;

    return Obx(
      () {
        final CartController cartController = Get.find<CartController>();

        CartItem? element;

        if (cartController.cartItems.isNotEmpty) {
          if (cartController.cartItems
              .any((element) => element?.dish?.id == dish?.id)) {
            element = cartController.cartItems
                .where((cartItem) {
                  debugPrint("cartItem?.dish?.id: ${cartItem?.dish?.id}");
                  return cartItem?.dish?.id == dish?.id;
                })
                .toList()
                .first;
          }
        }

        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: Image.network(
              'http://milzac.node.profcymabackend.com:3002${dish?.image ?? ""}',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(dish?.name ?? ""),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dish?.description ?? "",
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text('Price: ₹${dish?.price ?? ""}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => cartController.updateCart(dish, 'minus'),
                ),
                // Obx(() {
                //   // Observe the quantity value for this dish
                //   // final element = cartController.cartItems.where((e) => e?.dish?.id == dish?.id).toList().first;
                //   return Text('1');
                //   return Text('${element?.quantity ?? "0"}');
                // }),

                // Text('0'),
                Text('${element?.quantity ?? "0"}'),

                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => cartController.updateCart(dish, 'add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
