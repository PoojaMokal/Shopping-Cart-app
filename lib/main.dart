import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app_flutter/controller/cart_controller.dart';
import 'package:test_app_flutter/view/screens/screen_one.dart';
import 'package:test_app_flutter/view/screens/screen_two.dart';
import 'utils/size_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(CartController());

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return OrientationBuilder(
              builder: (BuildContext context2, Orientation orientation) {
                SizeConfig.init(constraints, orientation);

                return GetMaterialApp(
                  title: "Meui Project",
                  useInheritedMediaQuery: true,
                  debugShowCheckedModeBanner: false,
                  defaultTransition:
                  GetPlatform.isIOS ? Transition.cupertino : Transition.rightToLeft,
                  home: ScreenOne(),
                  // routes: {
                  //   '/screen_two': (_) => ScreenTwo(),
                  // },
                );
              });
        });
  }
}
