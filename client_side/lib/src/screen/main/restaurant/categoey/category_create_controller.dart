import 'package:client_side/src/api/category_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class CategoryCrrateBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CategoryCreateController());
  }
}

class CategoryCreateController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final categoryAPI = CategoryAPI();

  String get _name => nameController.text;
  String get _description => descriptionController.text;

  Future<void> createCategory() async {
    Map<String, dynamic> category = {
      "name": _name,
      "description": _description
    };

    final res = await categoryAPI.create(category);

    if (res != null && res.status) {
      nameController.text = "";
      descriptionController.text = "";
    }
  }
}
