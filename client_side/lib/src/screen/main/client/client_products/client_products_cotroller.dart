import 'package:client_side/src/api/category_api.dart';
import 'package:client_side/src/api/product_api.dart';
import 'package:client_side/src/model/category.dart';
import 'package:client_side/src/model/product.dart';
import 'package:client_side/src/model/user.dart';
import 'package:client_side/src/screen/main/client/create_orders_screen/create_orders_screen.dart';
import 'package:client_side/src/screen/main/client/detail_product/detail_product_screen.dart';
import 'package:client_side/src/screen/main/roles/roles_screen.dart';
import 'package:client_side/src/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ClientProductsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ClientProductsController());
  }
}

class ClientProductsController extends GetxController {
  User user = AuthService.to.user!;

  List<Category> categories = [];
  List<List<Product>> productLists = [<Product>[]];
  int currentIndex = 0;

  CategoryAPI categoryAPI = CategoryAPI();
  ProductAPI productAPI = ProductAPI();

  List<Product> get currentList {
    if (categories.isEmpty) return [];
    return productLists[currentIndex];
  }

  Category? get currentCategory {
    if (categories.isEmpty) return null;

    return categories[currentIndex];
  }

  @override
  void onInit() async {
    super.onInit();

    await getCategories();
    await getProduct();
  }

  Future<void> getCategories() async {
    final res = await categoryAPI.getAll();
    categories.addAll(res);

    productLists = List.generate(categories.length, (index) => <Product>[],
        growable: false);

    // DefaultTabController.of(Get.context!)!.index;
  }

  Future<void> getProduct() async {
    if (currentCategory == null) return;

    final res = await productAPI.getByCategoryId(currentCategory!.id);
    final index = getCategoryIndex(currentCategory!);
    productLists[index].addAll(res);
    print(currentList.length);
    update();
  }

  Future<void> selectCategory(int value) async {
    currentIndex = value;
    if (currentList.isNotEmpty) return;
    await getProduct();
  }

  void goToRoles() {
    Get.offAllNamed(RolesScreen.routeName,
        predicate: (route) => Get.currentRoute == RolesScreen.routeName);
  }

  void goToOrders() {
    Get.toNamed(CreateOrdersScreen.routeName);
  }

  void openBottomSheet(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: DetailProductScreen(
            product: product,
          ),
        );
      },
    );
  }

  Future<void> logout() async {
    await AuthService.to.logout();
  }

  int getCategoryIndex(Category category) {
    return categories.indexOf(category);
  }
}
