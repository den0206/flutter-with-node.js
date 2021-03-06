import 'package:client_side/src/screen/main/restaurant/categoey/category_create_screen.dart';
import 'package:client_side/src/screen/main/restaurant/categoey/product/product_create_screen.dart';
import 'package:client_side/src/screen/main/restaurant/ordres/restaurant_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class RestaurantOrdersScreen extends GetView<RestaurantOrdersController> {
  const RestaurantOrdersScreen({Key? key}) : super(key: key);
  static const routeName = '/restaurant_orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.user.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    controller.user.email,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[300],
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      image: AssetImage("assets/images/no-image.png"),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage("assets/images/no-image.png"),
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text("Select Role"),
              trailing: Icon(Icons.person),
              onTap: () {
                controller.goToRoles();
              },
            ),
            ListTile(
              title: Text("Create Category"),
              trailing: Icon(Icons.list_alt),
              onTap: () {
                Get.toNamed(CategoryCreateScreen.routeName);
              },
            ),
            ListTile(
              title: Text("Create Product"),
              trailing: Icon(Icons.food_bank),
              onTap: () {
                Get.toNamed(ProductCreateScreen.routeName);
              },
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.logout),
              onTap: () {
                controller.logout();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Clear Token"),
          onPressed: () {
            controller.logout();
          },
        ),
      ),
    );
  }
}
