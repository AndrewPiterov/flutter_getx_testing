class PnlCalculatorResult {
  PnlCalculatorResult({
    required this.percent,
    required this.value,
    required this.holdingValue,
  });

  final double percent;
  final double value;
  final double holdingValue;
}

class PnlCalculator {
  static PnlCalculatorResult calculate({
    required double coinAmount,
    required double totalInvestments,
    required double currentPrice,
  }) {
    // ...
    final holdingValue = coinAmount * currentPrice;
    final pnlValue = holdingValue - totalInvestments;
    final percent = ((holdingValue / totalInvestments) - 1) * 100;

    return PnlCalculatorResult(
      percent: percent,
      value: pnlValue,
      holdingValue: holdingValue,
    );
  }
}
