import 'package:flutter_getx_testing/models/order.dart';
import 'package:speed_up/speed_up.dart';

class Wallet {
  const Wallet({
    required this.orders,
  });

  final List<Order> orders;

  bool get isEmpty => orders.isEmpty;

  double get coinAmount => orders.map((e) => e.coinAmount).sum();

  double get totalInvested => orders.map((e) => e.totalPaid).sum();

  factory Wallet.empty() => const Wallet(orders: []);
}
