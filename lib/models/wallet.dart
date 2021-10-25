import 'package:flutter_getx_testing/models/order.dart';
import 'package:flutter_getx_testing/shared/shared.dart';
import 'package:speed_up/speed_up.dart';

abstract class IInvestmentData {
  double get coinAmount;
  double get totalInvested;
}

class Wallet implements IInvestmentData {
  Wallet({
    List<Order>? orders,
  }) : _orders = orders ?? [];

  List<Order> _orders;
  List<Order> get orders => _orders;

  bool get isEmpty => orders.isEmpty;

  @override
  double get coinAmount => orders.map((e) => e.coinAmount).sum();

  @override
  double get totalInvested => orders.map((e) => e.totalPaid).sum();

  factory Wallet.empty() => Wallet(orders: []);

  void add(Order order) {
    if (order.coinAmount <= 0) {
      throw InvalidAmountError(order.coinAmount);
    }
    _orders.add(order);
  }
}
