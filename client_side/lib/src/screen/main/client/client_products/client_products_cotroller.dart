import 'package:client_side/src/model/user.dart';
import 'package:client_side/src/screen/main/roles/roles_screen.dart';
import 'package:client_side/src/service/auth_service.dart';
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
