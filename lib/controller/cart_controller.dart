import 'package:get/get.dart';
import 'package:test_app_flutter/model/CartItem.dart';
import 'package:test_app_flutter/services/api_services.dart';
import '../model/dish_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItem?>[].obs;

  @override
  void onInit() {
    fetchCart();
    super.onInit();
  }

  Future<void> fetchCart() async {
    try {
      List<CartItem> items = await ApiService().fetchCart();

      cartItems.assignAll(items);
    } catch (e) {
      print(e);
    }
  }

  void updateCart(Dish? dish, String type) async {
    if (dish != null) {
      await ApiService.updateCartQuantity(
          dish.id ?? 0, dish.restaurent_id ?? 0, type);

      await fetchCart();
    }
  }
}
