import 'package:client_side/src/api/user_api.dart';
import 'package:client_side/src/model/user.dart';
import 'package:client_side/src/screen/auth/login/login_screen.dart';
import 'package:client_side/src/screen/main/roles/roles_screen.dart';
import 'package:client_side/src/utils/shared_pref.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_test/flutter_test.dart';

class AuthService extends GetxController {
  static AuthService get to => Get.find();
  User? user;
  final userApi = UserAPI();
  SharedPref _sharedPref = SharedPref();

  @override
  void onClose() {
    super.onClose();
    print("DESTROY");
  }

  Future<void> loadUser() async {
    if (user != null) return;
    final value = await _sharedPref.read("user");

    if (value == null) {
      return;
    }
    this.user = User.fromJson(value);
    print(user?.sessionToken);
    switchRouteName(user!);
  }

  Future<void> logout() async {
    await userApi.logout(user!.id);
    await _sharedPref.remove("user");
    this.user = null;
    Get.offAllNamed(LoginScreen.routeName,
        predicate: (route) => Get.currentRoute == LoginScreen.routeName);
  }

  Future<void> updateUser(String id) async {
    final current = await userApi.getById(id);
    if (current == null) return;
    _sharedPref.save("user", current.toJson());
    user = current;
  }

  void switchRouteName(User user) async {
    if (user.roles == null) return;

    if (user.roles!.length > 1) {
      Get.offAllNamed(RolesScreen.routeName,
          predicate: (route) => Get.currentRoute == RolesScreen.routeName);
      return;
    }

    Get.offAllNamed(user.roles![0].route,
        predicate: (route) => Get.currentRoute == user.roles![0].route);
  }
}
