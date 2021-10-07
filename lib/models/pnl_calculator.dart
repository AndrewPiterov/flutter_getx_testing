import 'package:flutter_getx_testing/models/wallet.dart';

class PnlData {
  PnlData({
    required this.value,
    required this.percent,
    required this.holdingValue,
  });

  final double value;
  final double percent;
  final double holdingValue;
}

class PnlCalculator {
  static PnlData calculate({
    required Wallet wallet,
    required double currentPrice,
  }) {
    return PnlData(
      value: 0,
      percent: 0,
      holdingValue: 0,
    );
  }
}
