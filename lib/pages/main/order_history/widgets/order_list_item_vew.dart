import 'package:flutter/material.dart';
import 'package:flutter_getx_testing/models/models.dart';
import 'package:speed_up_flutter/speed_up_flutter.dart';

class OrderListItemView extends StatelessWidget {
  const OrderListItemView(
    this.order, {
    required this.index,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Order order;
  final int index;
  final void Function()? onTap;

  static const textStyle = TextStyle(
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber,
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '> Buy #${order.id}',
                    style: textStyle,
                  ),
                ),
                Expanded(
                    child: Text(
                  '${order.coinAmount} BTC',
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ),
            20.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Date\n${order.date.toString()}',
                    style: textStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Paid: \$${order.totalPaid}',
                    style: textStyle,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
