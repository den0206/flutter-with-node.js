import 'package:client_side/src/model/category.dart';
import 'package:client_side/src/model/product.dart';
import 'package:client_side/src/screen/main/client/client_products/client_products_cotroller.dart';
import 'package:client_side/src/screen/main/client/client_products/no_product_screen.dart';
import 'package:client_side/src/screen/main/client/edit/client_edit_screen.dart';
import 'package:client_side/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ClientProductsScreen extends GetView<ClientProductsController> {
  ClientProductsScreen({Key? key}) : super(key: key);
  static const routeName = '/client_products';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientProductsController>(
      init: ClientProductsController(),
      builder: (_) {
        return DefaultTabController(
          length: controller.categories.length,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    controller.goToOrders();
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 8),
                        child: Icon(
                          Icons.badge_outlined,
                          color: Colors.black,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          height: 9,
                          width: 9,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(130),
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Products",
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[400],
                            ),
                            hintStyle: TextStyle(
                              fontSize: 17,
                              color: Colors.grey[400],
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!)),
                            contentPadding: EdgeInsets.all(15)),
                      ),
                    ),
                    TabBar(
                      indicatorColor: MyColors.primary,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey[400],
                      // isScrollable: false,
                      onTap: (value) async {
                        await controller.selectCategory(value);
                      },
                      tabs:
                          List.generate(controller.categories.length, (index) {
                        return Tab(
                          text: controller.categories[index].name,
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
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
                            placeholder:
                                AssetImage("assets/images/no-image.png"),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text("Edit User"),
                    trailing: Icon(Icons.edit_outlined),
                    onTap: () {
                      Get.toNamed(ClientEditScreen.routeName);
                    },
                  ),
                  ListTile(
                    title: Text("My Products"),
                    trailing: Icon(Icons.production_quantity_limits),
                  ),
                  ListTile(
                    title: Text("Select Role"),
                    trailing: Icon(Icons.person),
                    onTap: () {
                      controller.goToRoles();
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
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: controller.categories.map((Category category) {
                return GetBuilder<ClientProductsController>(
                  builder: (_) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: controller.currentList.length,
                      itemBuilder: (context, index) {
                        final product = controller.currentList[index];
                        return ProductCell(
                          product: product,
                        );
                      },
                    );
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class ProductCell extends GetView<ClientProductsController> {
  const ProductCell({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.openBottomSheet(context, product);
      },
      child: Container(
        height: 270,
        margin: EdgeInsets.only(top: 20),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -1,
                right: -1,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: MyColors.primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: Icon(Icons.add),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 150,
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: FadeInImage(
                      image: AssetImage("assets/images/pizza.png"),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage("assets/images/no_items.png"),
                    ),
                  ),
                  Container(
                      child: Text(
                    "Name",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, fontFamily: "NimbusSans"),
                  )),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "0.0\$",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "NimbusSans",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
