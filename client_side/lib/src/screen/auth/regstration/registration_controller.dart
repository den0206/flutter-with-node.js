import 'package:client_side/src/api/user_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegistrationController());
  }
}

class RegistrationController extends GetxController {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController passwordConfirmationTextController =
      TextEditingController();

  final userApi = UserAPI();

  String get _name => nameTextController.text.trim();
  String get _lastname => lastNameTextController.text.trim();
  String get _phone => lastNameTextController.text.trim();
  String get _email => emailTextController.text.trim();
  String get _password => passwordTextController.text.trim();
  String get _passwordConfirimation =>
      passwordConfirmationTextController.text.trim();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> registration() async {
    if (_password != _passwordConfirimation) {
      /// show alert
      print("not Match password");
      return;
    }

    Map<String, dynamic> user = {
      "name": _name,
      "lastname": _lastname,
      "email": _email,
      "phone": _phone,
      "password": _password,
    };

    final res = await userApi.create(user);

    if (res != null && res.status) {
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
      });
    }
  }
}
