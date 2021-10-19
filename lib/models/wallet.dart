import 'package:flutter_getx_testing/models/order.dart';
import 'package:speed_up/speed_up.dart';

abstract class IInvestmentData {
  double get coinAmount;
  double get totalInvested;
}

class Wallet implements IInvestmentData {
  const Wallet({
    required this.orders,
  });

  final List<Order> orders;

  bool get isEmpty => orders.isEmpty;

  @override
  double get coinAmount => orders.map((e) => e.coinAmount).sum();

  @override
  double get totalInvested => orders.map((e) => e.totalPaid).sum();

  factory Wallet.empty() => const Wallet(orders: []);
}
