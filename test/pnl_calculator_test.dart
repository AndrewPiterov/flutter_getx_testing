import 'package:flutter_getx_testing/models/pnl_calculator.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';

void main() {
  GivenWhenThenOptions.pads = 2;
/*
Given 1000 coins and with a total investment of $1000
When coin price raise up to $2
Then PNL % should be 100%
	And PNL value should be $1000
	And holding value should be $2000
*/
  given('1000 coins and with a total investment of \$1000', () {
    const coinAmount = 1000.0;
    const totalInvestment = 1000.0;

    testCases4<double, double, double, double>([
      TestCase4(2, 100, 1000, 2000),
      TestCase4(.1, -90, -900, 100),
      TestCase4(1, 0, 0, 1000),
      // ... more test cases
    ], (testCase) {
      // ...
      when('the coin price became \$${testCase.arg1}', () {
        late PnlCalculatorResult pnl;
        before(() {
          pnl = PnlCalculator.calculate(
            coinAmount: coinAmount,
            totalInvestments: totalInvestment,
            currentPrice: testCase.arg1,
          );
        });

        // ...
        then(
          'PNL % should be ${testCase.arg2}%',
          () => pnl.percent.should.be(testCase.arg2),
          and: {
            'PNL value should be \$${testCase.arg3}': () =>
                pnl.value.should.be(testCase.arg3),
            'holding value should be \$${testCase.arg4}': () =>
                pnl.holdingValue.should.be(testCase.arg4),
          },
        );
      });
    });
  });
}
