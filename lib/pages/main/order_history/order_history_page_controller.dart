import 'package:flutter_getx_testing/models/models.dart';
import 'package:flutter_getx_testing/shared/extensions.dart';
import 'package:flutter_getx_testing/shared/routing.dart';
import 'package:get/get.dart';

abstract class IOrderHistoryPageController {
  List<Order> get orders;
  Future goToOrderDetail(Order order);
}

class OrderHistoryPageController extends GetxController
    implements IOrderHistoryPageController {
  @override
  List<Order> get orders => 3.generate((index) => randomOrder(index)).toList();

  @override
  Future goToOrderDetail(Order order) async {
    // TODO: go to order
    Get.toNamed(AppRoutes.orderDetail, arguments: order);
  }
}
