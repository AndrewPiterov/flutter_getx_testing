import 'package:flutter/material.dart';
import 'package:flutter_getx_testing/models/models.dart';
import 'dart:math';

final _random = Random();

Order randomOrder({
  int? id,
  double? amount,
  double? price,
}) {
  final coinAmount = amount ?? _random.nextDouble() + 1;
  final coinnPrice = price ?? _random.nextDouble() + 1;
  return Order(
    id: (id ?? DateTime.now().microsecondsSinceEpoch).toString(),
    coinAmount: coinAmount,
    coinPrice: coinnPrice,
    date: DateTime.now().add(Duration(days: -_random.nextInt(100))),
  );
}

extension TextExtensiosn on String {
  Widget toText() => Text(this);
}

extension WidgetExtensiosn on Widget {
  Widget inCenter() => Center(child: this);
}
