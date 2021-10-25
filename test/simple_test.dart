import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';

void main() {
  Calculator calc = Calculator();

  given('Calucator', () {
    before(() => calc.clear());
    //
    when('add 10', () {
      before(() => calc.add(10));
      //
      then('should be 10', () {
        calc.res.should.be(10);
      });

      when('substract 5', () {
        before(() => calc.substract(5));
        then('should be 5', () {
          calc.res.should.be(5);
        });
      });
    });

    when('substruct 1', () {
      before(() => calc.substract(1));
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
