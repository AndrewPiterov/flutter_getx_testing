import 'package:flutter_test/flutter_test.dart';
import 'package:shouldly/shouldly.dart';

import 'given_when_then.dart';

void main() {
  Calculator calc = Calculator();
  given('Calucator',
      after: () => calc.clear(),
      body: () {
        //
        when('add 10',
            before: () => calc.add(10),
            body: () {
              //
              then('should be 10', () {
                calc.res.should.be(10);
              });

              when('substract 5',
                  before: () => calc.substract(5),
                  body: () {
                    then('should be 5', () {
                      calc.res.should.be(5);
                    });
                  });
            });

        when('substruct 1',
            before: () => calc.substract(1),
            body: () {
              //
              then('should be -1', () {
                calc.res.should.be(-1);
              });
            });
      });
}

class Calculator {
  num _res = 0;
  num get res => _res;

  void add(num value) {
    _res = _res + value;
  }

  void substract(num value) {
    _res = _res - value;
  }

  void clear() => _res = 0;

  @override
  String toString() => res.toString();
}
