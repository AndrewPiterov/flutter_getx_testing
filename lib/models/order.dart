class Order {
  const Order({
    required this.id,
    required this.coinAmount,
    required this.coinPrice,
    required this.totalPaid,
    required this.date,
  });

  final String id;
  final double coinAmount;
  final double coinPrice;
  final double totalPaid;
  final DateTime date;
}
