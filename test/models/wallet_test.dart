import 'package:flutter_getx_testing/models/wallet.dart';
import 'package:flutter_getx_testing/shared/extensions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shouldly/shouldly.dart';

void main() {
  test('Empty wallet test', () {
    final wallet = Wallet(orders: []);
    expect(wallet.isEmpty, isTrue);
  });

  test('Not empty wallet', () {
    final wallet = Wallet(orders: [randomOrder()]);
    expect(wallet.isEmpty, isFalse);
  });

  test('Not emoty wallet = amount is not zero', () {
    final wallet = Wallet(orders: [
      randomOrder(amount: 1),
    ]);
    expect(wallet.coinAmount, greaterThan(0));
  });

  test('Not emoty wallet = total invested is not 0', () {
    final wallet = Wallet(orders: [
      randomOrder(amount: 1),
    ]);
    expect(wallet.totalInvested, greaterThan(0));
  });

  test('Not emoty wallet = total invested is not 0 (2)', () {
    final wallet = Wallet(orders: [
      randomOrder(amount: 1.1, price: 1.1),
      randomOrder(amount: 2.2, price: 2.2),
    ]);

    // wallet.totalInvested.should.be(3.3);
    wallet.coinAmount.should.beCloseTo(3.3, delta: 0.00000000001);
  });
}
