import 'package:client_side/src/model/product.dart';
import 'package:client_side/src/utils/shared_pref.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class DetailProductController extends GetxController {
  final Product product;
  RxInt orderCount = 1.obs;

  DetailProductController(this.product);
  SharedPref sharedPref = SharedPref();

  List<Product> selectProduct = [];

  @override
  void onInit() async {
    super.onInit();
    await loadOrders();
  }

  void editCount(bool add) {
    if (add) {
      orderCount++;
    } else {
      if (orderCount <= 0) return;
      orderCount--;
    }
  }

  Future<void> loadOrders() async {
    final value = await sharedPref.read("order");
    if (value == null) return;

    value.forEach((data) {
      final product = Product.fromJson(data);
      selectProduct.add(product);
    });
  }

  void addCart() {
    product.quantity = orderCount.value;
    selectProduct.add(product);
    sharedPref.save("order", selectProduct);
  }
}
