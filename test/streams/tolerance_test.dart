import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Floats -', () {
    const a = 1.1;
    const b = 2.2;
    const sum = a + b;

    test('the problem: not equal', () {
      expect(sum, isNot(3.3));
    });

    test('solution: roughly equal', () {
      expect(sum, closeTo(3.3, 0.00000000001));
    });
  });

  group('DateTime -', () {
    test('the problem: not equal', () {
      final now1 = DateTime.now();
      final now2 = DateTime.now();
      expect(now2, isNot(now1));
    });

    test('solution: roughly equal', () {
      final now1 = DateTime.now();
      final now2 = DateTime.now();
      final delta = now2.difference(now1);
      print('Diff: $delta');
      print('Diff in ms: ${delta.inMilliseconds}');
      print('Diff in microseconds: ${delta.inMicroseconds}');
      expect(delta.inMicroseconds, isNot(0));
      expect(delta.inMicroseconds, greaterThan(0));
    });

    test('solution: not roughly equal with custom matcher', () {
      final now1 = DateTime.now();
      final now2 = DateTime.now();
      datesNotCloseTo(now1, now2, const Duration(microseconds: 1));
    }, skip: 'Not deterministic');

    test('solution: roughly equal with custom matcher', () {
      final now1 = DateTime.now();
      final now2 = DateTime.now();
      datesCloseTo(now1, now2, const Duration(microseconds: 2));
    });
  });
}

Matcher closeToPercentage(num value, double fraction) {
  final delta = value * fraction;
  return closeTo(value, delta);
}

void datesCloseTo(DateTime a, DateTime b, Duration fraction) {
  final delta = b.difference(a);
  print('Diff in microseconds: ${delta.inMicroseconds}');
  expect(0, closeTo(delta.inMicroseconds, fraction.inMicroseconds));
}

void datesNotCloseTo(DateTime a, DateTime b, Duration fraction) {
  final delta = b.difference(a);
  print('Diff in microseconds: ${delta.inMicroseconds}');
  expect(0, isNot(closeTo(delta.inMicroseconds, fraction.inMicroseconds)));
}
