import 'package:flutter_getx_testing/models/order.dart';
import 'package:flutter_getx_testing/models/wallet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shouldly/shouldly.dart';

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
      // expect(wallet.coinAmount, 1);
      wallet.coinAmount.should.be(0);
    });

    test('expect invested amount is 0', () {
      // Assert
      // expect(wallet.investedAmount, 0);
      wallet.investedAmount.should.beZero;
    });
  });

  group('when non empty wallet', () {
    setUp(() {
      // Act
      wallet.add(Order(coinAmount: 10, coinPrice: 1));
    });

    test('expect coin amount is not 0', () {
      // Assert
      // expect(wallet.coinAmount, 10);
      wallet.coinAmount.should.be(10);
    });

    test('expect invested amount is not 0', () {
      // Assert
      // expect(wallet.investedAmount, 0);
      wallet.investedAmount.should.be(10);
    });
  });

  group('when add invalid coin amount', () {
    test('expect throw exception when add negative coin amount', () {
      // expect(() => wallet.add(Order(coinAmount: -10, coinPrice: 1)),
      //     throwsException);

      Should.throwException(
          () => wallet.add(Order(coinAmount: -10, coinPrice: 1)));
    });

    test('expect throw exception when add 0 coin amount', () {
      // expect(() => wallet.add(Order(coinAmount: 0, coinPrice: 1)),
      //     throwsException);

      Should.throwException(
          () => wallet.add(Order(coinAmount: 0, coinPrice: 1)));
    });
  });

  group('when add with invalid coin price', () {
    test('expect throw exception when coin price is negative ', () {
      // expect(() => wallet.add(Order(coinAmount: 10, coinPrice: -1)),
      //     throwsException);

      Should.throwException(
          () => wallet.add(Order(coinAmount: 10, coinPrice: -1)));
    });

    test('expect throw exception when coin price is 0', () {
      // expect(() => wallet.add(Order(coinAmount: 100, coinPrice: 0)),
      //     throwsException);

      Should.throwException(
          () => wallet.add(Order(coinAmount: 100, coinPrice: 0)));
    });
  });
}
