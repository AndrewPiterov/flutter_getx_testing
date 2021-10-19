import 'package:flutter_getx_testing/pages/order_detail/order_detail_page_controller.dart';
import 'package:get/get.dart';

class OrderDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(OrderDetailPageController());
  }
}
