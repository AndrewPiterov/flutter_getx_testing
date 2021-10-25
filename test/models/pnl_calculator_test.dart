import 'package:flutter_getx_testing/models/order.dart';
import 'package:flutter_getx_testing/models/pnl_calculator.dart';
import 'package:flutter_getx_testing/models/wallet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';

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

  group('Non empty wallet without pnl changes', () {
    //
    // Assert
    const price = 31200.0;
    final wallet = Wallet(orders: [
      Order(
        coinAmount: 1.0,
        coinPrice: price,
      ),
    ]);
    const currentPrice = price;

    // Act
    final pnl = PnlCalculator.calculate(
      wallet: wallet,
      currentPrice: currentPrice,
    );

    test('holding value the same', () {
      pnl.holdingValue.should.be(price);
    });

    test('Pnl Value should be zero', () {
      pnl.value.should.beZero();
    });

    test('Pnl % should be 0', () {
      pnl.percent.should.beZero();
    });
  });

  group('Non empty wallet with Profit', () {
    // Assert
    final wallet = Wallet(orders: [
      Order(
        coinAmount: 1.0,
        coinPrice: 31200.0,
      ),
    ]);
    const currentPrice = 62400.0;

    // Act
    final pnl = PnlCalculator.calculate(
      wallet: wallet,
      currentPrice: currentPrice,
    );

    test('should have holding value', () {
      // Assert
      pnl.holdingValue.should.as('Holding Value').be(62400.0);
    });

    test('should have PNL Value', () {
      // Assert
      pnl.value.should.as('PNL Value').be(31200.0);
    });

    test('should have PNL Percent', () {
      // Assert
      pnl.percent.should.be(100.0);
    });
  });

  given('Non empty wallet with Loss', () {
    // Assert
    final wallet = Wallet(orders: [
      Order(
        coinAmount: 1.0,
        coinPrice: 62400.0,
      ),
    ]);
    const currentPrice = 31200.0;

    whenn('calculate', () {
      // Act
      final pnl = PnlCalculator.calculate(
        wallet: wallet,
        currentPrice: currentPrice,
      );
      // print(pnl);

      then('holding value should be less', () {
        // Assert
        pnl.holdingValue.should.as('Holding Value').be(31200.0);
      });

      then('PNL value should be negative', () {
        // Assert
        pnl.value.should.be(-31200.0);
      });

      then('PNL Percent should be negative', () {
        // Assert
        pnl.percent.should.be(-50.0);
      });
    });
  });
}
