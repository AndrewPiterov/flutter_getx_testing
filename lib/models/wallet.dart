import 'package:flutter_getx_testing/models/order.dart';

class Wallet {
  Wallet({
    required this.orders,
  });

  final List<Order> orders;

  double get coinAmount => 0;

  double get totalInvested => 0;

  factory Wallet.empty() => Wallet(orders: const []);
}
