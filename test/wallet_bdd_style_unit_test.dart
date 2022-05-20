import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:flutter_getx_testing/models/models.dart';
import 'package:shouldly/shouldly.dart';

void main() {
  GivenWhenThenOptions.pads = 2;
  given('empty wallet', () {
    late Wallet wallet;

    before(() {
      wallet = Wallet();
    });

    then('coin amount should be 0', () {
      wallet.coinAmount.should.beZero();
    }, and: {
      'invested amount should be 0': () {
        wallet.investedAmount.should.beZero();
      }
    });

    testCases4([
      TestCase4(10, 1, 10, 10),
      TestCase4(20, 2.5, 20, 50),
    ], (testCase) {
      when('we bought 10 coins per \$1', () {
        before(() {
          wallet.add(Order(coinAmount: 10, coinPrice: 1));
        });

        then('coin amount should be 10', () {
          wallet.coinAmount.should.be(10);
        }, and: {
          'invested amount should be \$10': () {
            wallet.investedAmount.should.be(10);
          }
        });
      });
    });

    testCases1<double>([
      TestCase1(0),
      TestCase1(-10),
    ], (testCase) {
      //
      when('add ${testCase.arg} coin amount', () {
        then('should throw exception', () {
          expect(
              () => wallet.add(Order(coinAmount: testCase.arg, coinPrice: 1)),
              throwsException);
        });
      });
    });
  });
}
