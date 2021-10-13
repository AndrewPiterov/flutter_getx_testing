import 'package:flutter/material.dart';
import 'package:flutter_getx_testing/models/models.dart';
import 'package:flutter_getx_testing/services/services.dart';
import 'package:flutter_getx_testing/shared/routing.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

abstract class IOrderListPageController {
  /// Stream of order list
  Stream<List<Order>> get orders;

  /// Pagination: Load more orders
  Future loadMoreOrders();

  /// Save new Order
  Future save(double amount, double price);

  /// Open Order' detail page
  Future goToOrderDetail(Order order);
}

class OrderListPageController extends GetxController {
  OrderListPageController(
    this._ordersRepository,
    this._dateTimeAdapter,
    this._navigationService,
    this._toastrService,
  );

  final IOrdersRepository _ordersRepository;
  final IDateTimeAdapter _dateTimeAdapter;
  final INavigationService _navigationService;
  final IToastrService _toastrService;

  final _orders = <Order>[].obs;
  List<Order> get orders => _orders;

  @override
  void onInit() {
    super.onInit();

    // Getting orders
    _ordersRepository.orders$.listen((event) {
      _orders.assignAll(event);
    });
  }

  /// Save new Order
  Future save(double amount, double price) async {
    // Create order
    final newOrder = Order(
      coinAmount: amount,
      coinPrice: price,
      date: _dateTimeAdapter.now,
    );

    // Getting orders
    final saveResult = await _ordersRepository.save(newOrder);
    if (saveResult.isFail) {
      // Showing error
      _toastrService.error(saveResult.errorMessage!);
      return;
    }

    _toastrService.success('Success');

    // Navigate to newly created order
    await _navigationService.goTo(
      AppRoutes.orderDetail,
      args: saveResult.value!.id,
    );
  }

  Future loadMoreOrders() async {
    await _ordersRepository.loadMoreOrders();
  }

  Future goToOrderDetail(Order order) async {
    // Navigate to newly created order
    // ! Problem: 3rd party + static member
    Get.toNamed(
      AppRoutes.orderDetail,
      arguments: {'id': order.id},
    );
  }
}
