import 'package:flutter_getx_testing/models/order.dart';
import 'package:flutter_getx_testing/models/wallet.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Arrange & Act
  late Wallet wallet;

  // before each test
  setUp(() {
    wallet = Wallet();
  });

  // after EACH test
  tearDown(() {
    /// wallet = null;
  });

  // before ALL tests
  setUpAll(() {});

  // after ALL tests
  tearDownAll(() {});

  group('when empty wallet', () {
    test('expect coin amount is 0', () {
      // Assert
      expect(wallet.coinAmount, 0);
    });

    test('expect invested amoun is 0', () {
      // Assert
      expect(wallet.investedAmount, 0);
    });
  });

  group('when non empty wallet', () {
    setUp(() {
      // Act
      wallet.add(Order(coinAmount: 10, coinPrice: 1));
    });

    test('extect coin amount is not 0', () {
      // Assert
      expect(wallet.coinAmount, 10);
    });

    test('extect invested amount is not 0', () {
      // Assert
      expect(wallet.investedAmount, 10);
    });
  });

  group('when add invalid coin amount', () {
    test('extect throw exeption when add negative coin amount', () {
      expect(() => wallet.add(Order(coinAmount: -10, coinPrice: 1)),
          throwsException);
    });

    test('extect throw exeption when add 0 coin amount', () {
      expect(() => wallet.add(Order(coinAmount: 0, coinPrice: 1)),
          throwsException);
    });
  });

  group('when add with invalid coin price', () {
    test('extect throw exeption when coin price is negative ', () {
      expect(() => wallet.add(Order(coinAmount: 10, coinPrice: -1)),
          throwsException);
    });

    test('extect throw exeption when coin price is 0', () {
      expect(() => wallet.add(Order(coinAmount: 100, coinPrice: 0)),
          throwsException);
    });
  });
}
