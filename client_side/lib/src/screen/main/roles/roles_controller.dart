import 'package:client_side/src/model/role.dart';
import 'package:client_side/src/model/user.dart';
import 'package:client_side/src/service/auth_service.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class RolesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RolesConstroller());
  }
}

class RolesConstroller extends GetxController {
  User user = AuthService.to.user!;

  @override
  void onInit() async {
    super.onInit();
  }

  void goToPage(Role role) {
    Get.offAllNamed(role.route,
        predicate: (route) => Get.currentRoute == role.route);
  }
}
