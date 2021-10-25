import 'package:flutter_test/flutter_test.dart';
import 'package:shouldly/shouldly.dart';

class Assert {
  static void isTrue(bool value) {}
  static void isFalse(bool value) {}

  static void isNull(Object? value) {}

  static void areEqual<T>(T expected, T actual) {}

  static void contains<T>(T expected, Iterable<T> actual) {}

  static void startWith(String expected, String actual) {}
}

const someBoolean = true;
const Object? someValue = null;
const someCollection = [1, 2, 3];
const obj = 1;
const someString = 'foo baz';
const someNumber = 7;

void assertion() {}

void main() {
  group('Assert', () {
    Assert.isTrue(someBoolean);

    Assert.isNull(someValue);

    Assert.areEqual(7, someNumber);

    Assert.contains(obj, someCollection);

    Assert.startWith('foo', someString);
  });

  group('Expect', () {
    test('description', () {
      expect(someBoolean, isTrue);
      expect(someBoolean, isNot(false));

      expect(someValue, isNull);

      expect(someNumber, equals(7));

      expect(someCollection, contains(obj));

      expect(someString, startsWith('foo'));
    });
  });

  group('Shouldly', () {
    test('description', () {
      someBoolean.should.beTrue();
      someBoolean.should.not.beFalse();

      someValue.should.beNull();

      someNumber.should.be(7);

      someCollection.should.contain(obj);

      someString.should.startWith('foo').and.endWith('baz');
    });
  });
}
