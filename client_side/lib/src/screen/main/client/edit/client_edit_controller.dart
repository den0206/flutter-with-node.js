import 'package:client_side/src/api/user_api.dart';
import 'package:client_side/src/model/user.dart';
import 'package:client_side/src/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ClientEditBuinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClientEditController());
  }
}

class ClientEditController extends GetxController {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();

  final userApi = UserAPI();

  User user = AuthService.to.user!;
  late User editedUser;

  String get _name => nameTextController.text.trim();
  String get _lastname => lastNameTextController.text.trim();
  String get _phone => phoneTextController.text.trim();

  @override
  void onInit() {
    super.onInit();
    nameTextController.text = user.name;
    lastNameTextController.text = user.lastName;
    phoneTextController.text = user.phone;

    editedUser = user;
  }

  Future<void> updateuser() async {
    editedUser.name = _name;
    editedUser.lastName = _lastname;
    editedUser.phone = _phone;

    final Map<String, dynamic> params = {
      "id": editedUser.id,
      "name": editedUser.name,
      "lastname": editedUser.lastName,
      "phone": editedUser.phone,
      "image": null
    };

    final response = await userApi.update(params);

    if (response != null && response.status) {
      print("UPDARW");

      await AuthService.to.updateUser(user.id);
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
      });
    }
  }
}
