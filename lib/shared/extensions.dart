import 'package:flutter/material.dart';
import 'package:flutter_getx_testing/models/models.dart';
import 'dart:math';

final _random = Random();

extension DoubleIterableExtension on Iterable<double> {
  double sum() =>
      fold<double>(0, (previousValue, element) => previousValue + element);
}

extension IntIterableExtension on Iterable<int> {
  int sum() =>
      fold<int>(0, (previousValue, element) => previousValue + element);
}

extension IntExtension on int {
  Iterable<T> generate<T>(T Function(int index) func) sync* {
    for (var i = 0; i < this; i++) {
      yield func(i);
    }
  }
}

Order randomOrder([int? index]) {
  return Order(
    id: (index == null ? _random.nextInt(1000) : index + 1).toString(),
    coinAmount: _random.nextDouble(),
    coinPrice: _random.nextDouble(),
    totalPaid: _random.nextDouble(),
    date: DateTime.now().add(Duration(days: -_random.nextInt(100))),
  );
}

extension TextExtensiosn on String {
  Widget toText() => Text(this);
}

extension WidgetExtensiosn on Widget {
  Widget inCenter() => Center(child: this);
}
