import 'package:client_side/src/screen/auth/login/login_controller.dart';
import 'package:client_side/src/screen/auth/login/login_screen.dart';
import 'package:client_side/src/screen/auth/regstration/registration_controller.dart';
import 'package:client_side/src/screen/auth/regstration/registration_screen.dart';
import 'package:client_side/src/screen/main/client/client_products/client_products_cotroller.dart';
import 'package:client_side/src/screen/main/client/client_products/client_products_screen.dart';
import 'package:client_side/src/screen/main/client/edit/client_edit_controller.dart';
import 'package:client_side/src/screen/main/client/edit/client_edit_screen.dart';
import 'package:client_side/src/screen/main/driver/products/driver_products_screen.dart';
import 'package:client_side/src/screen/main/restaurant/ordres/restaurant_orders_screen.dart';
import 'package:client_side/src/screen/main/roles/roles_controller.dart';
import 'package:client_side/src/screen/main/roles/roles_screen.dart';
import 'package:client_side/src/screen/root.dart';
import 'package:client_side/src/service/auth_service.dart';

import 'package:client_side/src/utils/my_colors.dart';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: "NimbusSans",
          primaryColor: MyColors.primary,
          appBarTheme: AppBarTheme(backgroundColor: Colors.red)),
      getPages: [
        GetPage(
          name: Root.routeName,
          page: () => Root(),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: RegistrationScreen.routeName,
          page: () => RegistrationScreen(),
          binding: RegistrationBinding(),
        ),
        GetPage(
          name: RolesScreen.routeName,
          page: () => RolesScreen(),
          binding: RolesBinding(),
        ),
        GetPage(
          name: ClientProductsScreen.routeName,
          page: () => ClientProductsScreen(),
          binding: ClientProductsBindings(),
        ),
        GetPage(
          name: RestaurantOrdersScreen.routeName,
          page: () => RestaurantOrdersScreen(),
        ),
        GetPage(
          name: DriverProductsScreen.routeName,
          page: () => DriverProductsScreen(),
        ),
        GetPage(
          name: ClientEditScreen.routeName,
          page: () => ClientEditScreen(),
          binding: ClientEditBuinding(),
        ),
      ],
      initialBinding: InitialBindings(),
      initialRoute: Root.routeName,
    );
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.lazyPut(() => LoginController());
  }
}