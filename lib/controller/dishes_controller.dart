import 'package:get/get.dart';
import '../model/dish_model.dart';
import '../services/api_services.dart';


class DishesController extends GetxController {
  var recommendedDishes = <Dish>[].obs;
  var userDishes = <Dish>[].obs;

  @override
  void onInit() {
    fetchRecommendedDishes();
    fetchUserDishes();
    super.onInit();
  }

  void fetchRecommendedDishes() async {
    try {
      var dishes = await ApiService.fetchUserDishes();
      recommendedDishes.assignAll(dishes);
    } catch (e) {
      print(e);
    }
  }

  void fetchUserDishes() async {
    try {
      var dishes = await ApiService.fetchUserDishes();
      userDishes.assignAll(dishes);
    } catch (e) {
      print(e);
    }
  }
}
