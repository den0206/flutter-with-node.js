import 'package:client_side/src/api/user_api.dart';
import 'package:client_side/src/model/user.dart';
import 'package:client_side/src/screen/root.dart';
import 'package:client_side/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final userApi = UserAPI();
  SharedPref _sharedPref = SharedPref();

  String get _email => emailController.text.trim();
  String get _password => passwordController.text.trim();

  @override
  void onInit() async {
    super.onInit();
    // await checkLogin();
  }

  @override
  void onClose() {
    print("Close");
    super.onClose();
  }

  Future<void> checkLogin() async {
    final value = await _sharedPref.read("user");

    if (value == null) return;
    final user = User.fromJson(value);

    if (user.sessionToken != null) {
      switchRouteName(user);
    }
  }

  Future<void> login() async {
    final res = await userApi.login(_email, _password);
    if (res != null && res.status) {
      User user = User.fromJson(res.data);

      _sharedPref.save("user", user.toJson());
      switchRouteName(user);
    } else {
      print("Can7t Login");
    }
  }

  void switchRouteName(User user) async {
    if (user.roles == null) return;
    Get.offAllNamed(Root.routeName,
        predicate: (route) => Get.currentRoute == Root.routeName);
  }
}
