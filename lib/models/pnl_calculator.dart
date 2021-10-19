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

  @override
  String toString() => 'PNL: \$$value ($percent%)';
}

class PnlCalculator {
  static PnlData calculate({
    required IInvestmentData wallet,
    required double currentPrice,
  }) {
    final holdingValue = wallet.coinAmount * currentPrice;

    final value = holdingValue - wallet.totalInvested;

    var percent = 0.0;

    if (value != 0) {
      if (wallet.totalInvested > 0) {
        if (value > 0) {
          percent = ((holdingValue / wallet.totalInvested) - 1) * 100;
        } else {
          percent = ((holdingValue / wallet.totalInvested)) * 100;
        }
      }
    }

    return PnlData(
      value: value,
      percent: (value < 0 ? -percent : percent),
      holdingValue: holdingValue,
    );
  }
}
