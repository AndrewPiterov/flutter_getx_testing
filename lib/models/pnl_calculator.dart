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
    required Wallet wallet,
    required double currentPrice,
  }) {
    final holding = wallet.coinAmount * currentPrice;
    final value = holding - wallet.totalInvested;
    final percent =
        wallet.isEmpty ? 0.0 : (holding / wallet.totalInvested) * 100;

    return PnlData(
      value: value,
      percent: value < 0 ? -percent : percent,
      holdingValue: holding,
    );
  }
}
