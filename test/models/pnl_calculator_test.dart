import 'package:flutter_getx_testing/models/order.dart';
import 'package:flutter_getx_testing/models/pnl_calculator.dart';
import 'package:flutter_getx_testing/models/wallet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shouldly/shouldly.dart';

import '../given_when_then.dart';

void main() {
  test('PNL with empty wallet', () {
    // Assert
    final wallet = Wallet.empty();
    const currentPrice = 100000.0;

    // Act
    final pnl = PnlCalculator.calculate(
      wallet: wallet,
      currentPrice: currentPrice,
    );

    // Assert
    expect(pnl.holdingValue, 0);
    expect(pnl.value, 0);
    expect(pnl.percent, 0);
  });

  group('Non empty wallet with Profit', () {
    // Assert
    const wallet = Wallet(orders: [
      Order(
        coinAmount: 1,
        coinPrice: 20000,
      ),
    ]);
    const currentPrice = 100000.0;

    // Act
    final pnl = PnlCalculator.calculate(
      wallet: wallet,
      currentPrice: currentPrice,
    );

    test('should have holding value', () {
      // Assert
      pnl.holdingValue.should.as('Holding Value').beGreaterThan(0);
    });

    test('should have PNL Value', () {
      // Assert
      pnl.value.should.as('PNL Value').beAbove(0);
    });

    test('should have PNL Percent', () {
      // Assert
      pnl.percent.should.beGreaterThan(0);
    });
  });

  given('Non empty wallet with Loss', body: () {
    // Assert
    const wallet = Wallet(orders: [
      Order(
        coinAmount: 1,
        coinPrice: 100000,
      ),
    ]);
    const currentPrice = 50000.0;

    when('calculate', body: () {
      // Act
      final pnl = PnlCalculator.calculate(
        wallet: wallet,
        currentPrice: currentPrice,
      );
      // print(pnl);

      then('holding value should be less', () {
        // Assert
        pnl.holdingValue.should.as('Holding Value').be(50000);
      });

      then('PNL value should be negative', () {
        // Assert
        pnl.value.should.be(-50000);
      });

      then('PNL Percent should be negative', () {
        // Assert
        pnl.percent.should.be(-50);
      });
    });
  });
}
