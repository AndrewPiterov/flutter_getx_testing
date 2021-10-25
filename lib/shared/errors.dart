import 'package:speed_up/speed_up.dart';

class InvalidAmountError extends Error {
  InvalidAmountError(this.amount, {String? message}) : _message = message;

  final num amount;
  final String? _message;

  String get message =>
      isStringNullOrEmpty(_message) ? '$amount is invalid amount' : _message!;

  @override
  String toString() => message;
}
