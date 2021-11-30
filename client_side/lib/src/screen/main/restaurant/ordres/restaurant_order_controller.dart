import 'package:client_side/src/model/user.dart';
import 'package:client_side/src/screen/main/roles/roles_screen.dart';
import 'package:client_side/src/service/auth_service.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RestaurantOrdersBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(RestaurantOrdersController());
  }
}

class RestaurantOrdersController extends GetxController {
  User user = AuthService.to.user!;

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goToRoles() {
    Get.offAllNamed(RolesScreen.routeName,
        predicate: (route) => Get.currentRoute == RolesScreen.routeName);
  }

  Future<void> logout() async {
    await AuthService.to.logout();
  }
}
