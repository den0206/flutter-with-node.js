import 'package:client_side/src/api/category_api.dart';
import 'package:client_side/src/api/product_api.dart';
import 'package:client_side/src/model/category.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class ProductCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductCreateController());
  }
}

class ProductCreateController extends GetxController {
  Category? selectCategory;
  List<Category> categories = [];

  final productAPI = ProductAPI();
  final categoryAPI = CategoryAPI();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  MoneyMaskedTextController priceController = MoneyMaskedTextController();

  String get _name => nameController.text;
  String get _description => descriptionController.text;
  double get _price => priceController.numberValue;

  List<DropdownMenuItem<Category>> get categoryItems {
    final List<DropdownMenuItem<Category>> res = [];

    categories.forEach((category) {
      final item = DropdownMenuItem(
        child: Text(category.name),
        value: category,
      );
      res.add(item);
    });

    return res;
  }

  @override
  void onInit() async {
    super.onInit();

    await getCategory();
  }

  Future<void> getCategory() async {
    final current = await categoryAPI.getAll();

    print(current.length);
    categories.addAll(current);

    update();
  }

  void onChange(Category? value) {
    selectCategory = value;
    update();
  }

  Future<void> createProduct() async {
    if (selectCategory == null) return;

    final Map<String, dynamic> product = {
      "name": _name,
      "description": _description,
      "price": _price,
      "category_id": int.parse(selectCategory!.id),
    };

    final req = await productAPI.create(product);

    if (req != null && req.status) {
      await Future.delayed(Duration(seconds: 200));
      Get.back();
    }
  }
}
