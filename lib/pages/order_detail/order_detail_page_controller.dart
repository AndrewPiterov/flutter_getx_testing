import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_getx_testing/models/order.dart';
import 'package:flutter_getx_testing/services/services.dart';
import 'package:get/get.dart';
import 'package:speed_up_get/speed_up_get.dart';

class OrderDetailPageController extends GetxController with GetxSubscribing {
  OrderDetailPageController({IThemeService? themeService})
      : _themeService = themeService ?? Get.find();

  final IThemeService _themeService;

  bool get isDarkMode => _themeService.isDarkMode;

  final _order = Rxn<Order>();
  Order? get order => _order.value;

  final _isFetching = true.obs;
  bool get isFetching => _isFetching.value;

  @override
  void onInit() {
    super.onInit();

    final orderId = (Get.arguments as Map<String, dynamic>)['id']?.toString();

    subscribe(
        FirebaseFirestore.instance
            .collection('orders')
            .doc(orderId)
            .snapshots(), (DocumentSnapshot<Map<String, dynamic>> value) {
      final data = value.data()!;
      print(data);
      final order = Order(
        id: value.id,
        coinAmount: double.parse(data['amount'].toString()),
        coinPrice: double.parse(data['price'].toString()),
        date: (data['date'] as Timestamp).toDate(),
      );
      _order.value = order;
      _isFetching.value = false;
      print(data);
    });
  }
}
