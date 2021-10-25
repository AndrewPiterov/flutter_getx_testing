import 'package:flutter_getx_testing/models/order.dart';
import 'package:flutter_getx_testing/models/wallet.dart';
import 'package:flutter_getx_testing/shared/shared.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Wallet', () {
    // Empty wallet
    final wallet = Wallet();

    expect(wallet.isEmpty, isTrue);
    expect(wallet.coinAmount, 0);
    expect(wallet.totalInvested, 0);

    // Add coins
    wallet.add(Order(coinAmount: 20, coinPrice: 10));

    expect(wallet.isEmpty, isFalse);
    expect(wallet.coinAmount, 20);
    expect(wallet.totalInvested, 200);

    // Can't put negative amount
    expect(() => wallet.add(Order(coinAmount: -1, coinPrice: 1000)),
        throwsA(TypeMatcher<InvalidAmountError>()));
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
}
