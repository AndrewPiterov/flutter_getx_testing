import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_testing/models/models.dart';
import 'package:flutter_getx_testing/services/services.dart';
import 'package:flutter_getx_testing/shared/routing.dart';
import 'package:get/get.dart';

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
  // final FirebaseOrdersRepository _ordersRepository = Get.find();
  // final UtcDateTimeAdapter _dateTimeAdapter = Get.find();
  // final GetXNavigationService _navigationService = Get.find();
  // final ToastrService _toastrService = Get.find();

  // OrderListPageController({
  //   FirebaseOrdersRepository? ordersRepository,
  //   UtcDateTimeAdapter? dateTimeAdapter,
  //   GetXNavigationService? navigationService,
  //   ToastrService? toastrService,
  // })  : _ordersRepository = ordersRepository ?? Get.find(),
  //       _dateTimeAdapter = dateTimeAdapter ?? Get.find(),
  //       _navigationService = navigationService ?? Get.find(),
  //       _toastrService = toastrService ?? Get.find();

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

  late ScrollController scrollController;
  final isBusyToFetcchNextPage = false.obs;
  final noMoreOreders = false.obs;

  @override
  void onInit() {
    super.onInit();

    scrollController = ScrollController()..addListener(_onScroll);

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
    final pageCount = await _ordersRepository.loadMoreOrders();
    noMoreOreders.value = pageCount < 1;
  }

  Future goToOrderDetail(Order order) async {
    // Navigate to newly created order
    // ! Problem: 3rd party + static member
    Get.toNamed(
      AppRoutes.orderDetail,
      arguments: {'id': order.id},
    );
  }

  Future _onScroll() async {
    if (noMoreOreders.isTrue) {
      debugPrint('there is no more orders');
      return;
    }
    final offset = scrollController.position.pixels -
        scrollController.position.maxScrollExtent;

    // debugPrint('Scrolling: $offset');

    if (offset > 50) {
      if (isBusyToFetcchNextPage.isTrue) return;

      debugPrint('Fetch next page...');

      isBusyToFetcchNextPage.value = true;

      await Future.delayed(const Duration(milliseconds: 700));
      await loadMoreOrders();

      debugPrint('Fetch next page: DONE');

      isBusyToFetcchNextPage.value = false;
    }
  }
}

// TODO: neeed for initial version
// class OrderListPageController extends GetxController {
//   final _orders = <Order>[].obs;
//   List<Order> get orders => _orders;
//   late FirebaseOrdersRepository _repository;

//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize the repository
//     _repository = new FirebaseOrdersRepository();
//     // Subscribe to get updates
//     _repository.orders$.listen((orders) {
//       _orders.assignAll(orders);
//     });
//   }

//   /// Save new Order
//   Future save(double amount, double price) async {
//     // Create order
//     final newOrder =
//         Order(coinAmount: amount, coinPrice: price, date: DateTime.now());

//     final saveResult = await _repository.save(newOrder);
//     if (saveResult.isFail) {
//       // Log error
//       Get.find<AppLogger>().logError(saveResult.errorMessage!);
//       // Show error on UI
//       Fluttertoast.showToast(
//           msg: saveResult.errorMessage!, backgroundColor: Colors.red);
//       return;
//     }

//     // Navigate to newly created order
//     Get.toNamed(AppRoutes.orderDetail, arguments: saveResult.value);
//   }
// }

class AppLogger {
  void logError(String message) {}
}


/*
class OrderListPageController extends GetxControllser {
  final _orders = <Order>[].obs;
  List<Order> get orders => _orders;

  @override
  void onInit() {
    super.onInit();

    // Fetching data for initialization
    // Problem: new keyword
    final repository = new FirebaseOrdersRepository();
    repository.orders$.listen((orders) {
      _orders.assignAll(orders);
    });
  }

  /// Save new Order
  Future save(double amount, double price) async {
    // Create order
    final newOrder = Order(
      coinAmount: amount,
      coinPrice: price,
      // Problem: static functions
      date: DateTime.now(),
    );

    final saveResult =
        // Problem: Service Locator
        await Get.find<FirebaseOrdersRepository>().save(newOrder);
    if (saveResult.isFail) {
      // Showing error
      // Problem: 3rd party package
      Fluttertoast.showToast(
        msg: saveResult.errorMessage!,
        backgroundColor: Colors.red,
      );
      return;
    }

    // Navigate to newly created order
    // Problem: 3rd party + static member
    Get.toNamed(AppRoutes.orderDetail, arguments: saveResult.value);
  }
}
*/