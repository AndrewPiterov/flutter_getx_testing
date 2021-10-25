import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  const Order({
    this.id,
    required this.coinAmount,
    required this.coinPrice,
    this.date,
  });

  final String? id;
  final double coinAmount;
  final double coinPrice;
  double get totalPaid => coinAmount * coinPrice;
  final DateTime? date;

  Map<String, dynamic> get asJson => {
        'id': id,
        'date': date == null ? null : Timestamp.fromDate(date!),
        'amount': coinAmount,
        'price': coinPrice,
      };

  Order copyWith({String? id}) {
    return Order(
      id: id ?? this.id,
      coinAmount: coinAmount,
      coinPrice: coinPrice,
      date: date,
    );
  }

  @override
  List<Object?> get props => [
        id,
        coinAmount,
        coinPrice,
        date,
      ];
}
