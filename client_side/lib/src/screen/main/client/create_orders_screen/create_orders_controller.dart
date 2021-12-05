import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class CreateOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateOrdersController());
  }
}

class CreateOrdersController extends GetxController {}
