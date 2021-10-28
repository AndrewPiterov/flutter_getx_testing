import 'package:flutter_getx_testing/models/order.dart';
import 'package:flutter_getx_testing/models/pnl_calculator.dart';
import 'package:flutter_getx_testing/models/wallet.dart';
import 'package:flutter_getx_testing/services/services.dart';
import 'package:flutter_getx_testing/shared/shared.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Wallet', () {
    // Empty Wallet
    final wallet = Wallet();

    // See values
    wallet.isEmpty;
    wallet.coinAmount;
    wallet.totalInvested;

    // Add coins
    wallet.add(Order(coinAmount: 20, coinPrice: 10));

    // New values
    wallet.isEmpty;
    wallet.coinAmount;
    wallet.totalInvested;

    // Can't put negative amount
    wallet.add(Order(coinAmount: -1, coinPrice: 1000));
  });

  test('Wallet can add more coins', () {
    // Assert - create wallet object
    final wallet = Wallet();

    // Act - adding coins
    wallet.add(Order(coinAmount: 20, coinPrice: 10));

    // Asseet - verify result
    expect(wallet.isEmpty, isFalse);
    expect(wallet.coinAmount, 20);
    expect(wallet.totalInvested, 200);
  });

  test('Wallet can not add negative amount', () {
    // Assert - create wallet object
    final wallet = Wallet();

    // Asseet - verify throwing error
    expect(() => wallet.add(Order(coinAmount: -1, coinPrice: 2)),
        throwsA(TypeMatcher<InvalidAmountError>()));
  });

  test('Wallet', () {
    final wallet = Wallet();

    expect(wallet.isEmpty, isTrue);
    expect(wallet.coinAmount, 0);
    expect(wallet.totalInvested, 0);

    wallet.add(Order(coinAmount: 20, coinPrice: 10));

    expect(wallet.isEmpty, isFalse);
    expect(wallet.coinAmount, 20);
    expect(wallet.totalInvested, 200);

    expect(() => wallet.add(Order(coinAmount: -1, coinPrice: 2)),
        throwsA(TypeMatcher<InvalidAmountError>()));
  });

  group('PnL', () {
    //   test('pnl', () {
    //     final calc = PnlCalculator();

    //     // Should be Profit
    //     var pnl = calc.calculate(
    //       coinAmount: 1,
    //       totalInvested: 50,
    //       currentPrice: 800,
    //     );

    //     print(pnl.holdingValue);
    //     print(pnl.percent);
    //     print(pnl.value);

    //     // Should be Loss
    //     pnl = calc.calculate(
    //       coinAmount: 1,
    //       totalInvested: 100,
    //       currentPrice: 50,
    //     );

    //     // Should be non Profit non Loss
    //     pnl = calc.calculate(
    //       coinAmount: 1,
    //       totalInvested: 100,
    //       currentPrice: 100,
    //     );

    //     // Should be Loss
    //     pnl = calc.calculate(
    //       coinAmount: 1,
    //       totalInvested: 100,
    //       currentPrice: 50,
    //     );
    //     print(pnl.holdingValue); // 50
    //     print(pnl.percent); // -50
    //     print(pnl.value); // -50

    //     print(pnl.holdingValue); // 100
    //     print(pnl.percent); // 0
    //     print(pnl.value); // 0
    //   });
  });
}
