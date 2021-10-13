import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/subjects.dart';

void main() {
  test('should emit numbers in decreasing order', () {
    final auth = Counter();

    const actions = [1, 2, 2, 3, 3, 3, 3, 4, 5];
    auth.addBehavior(actions);

    expect(auth.isAuth$, emitsInOrder([1, 2, 3, 4, 5]));
  });
}

class Counter {
  final _isAuthSubject = BehaviorSubject<int?>();
  Stream<int?> get isAuth$ => _isAuthSubject.distinct();

  Future addBehavior(Iterable<int> actions) async {
    await Future.delayed(const Duration(milliseconds: 100));
    for (var item in actions) {
      _isAuthSubject.add(item);
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }
}
