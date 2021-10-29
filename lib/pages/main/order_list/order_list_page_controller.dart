import 'package:flutter/material.dart';
import 'package:flutter_getx_testing/models/models.dart';
import 'package:flutter_getx_testing/pages/pages.dart';
import 'package:flutter_getx_testing/services/services.dart';
import 'package:get/get.dart';

import 'package:fluttertoast/fluttertoast.dart';

class OrderListPageController extends GetxController {
  final _orders = <Order>[].obs;
  List<Order> get orders => _orders;
  late FirebaseOrdersRepository _repository;

  @override
  void onInit() {
    super.onInit();
    // Initialize the repository
    _repository = FirebaseOrdersRepository();
    // Subscribe to get updates
    _repository.orders$.listen((orders) {
      _orders.assignAll(orders);
    });
  }

  /// Save new Order
  Future save(double amount, double price) async {
    // Create order
    final newOrder =
        Order(coinAmount: amount, coinPrice: price, date: DateTime.now());

    final saveResult = await _repository.save(newOrder);
    if (saveResult.isFail) {
      // Log error
      Get.find<AppLogger>().logError(saveResult.errorMessage!);
      // Show error on UI
      Fluttertoast.showToast(
          msg: saveResult.errorMessage!, backgroundColor: Colors.red);
      return;
    }

    // Navigate to newly created order
    Get.toNamed(AppRoutes.orderDetail, arguments: saveResult.value);
  }
}
