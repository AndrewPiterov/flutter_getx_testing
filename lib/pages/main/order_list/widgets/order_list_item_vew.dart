import 'package:flutter/material.dart';
import 'package:flutter_getx_testing/models/models.dart';
import 'package:speed_up_flutter/speed_up_flutter.dart';
import 'package:intl/intl.dart';

class OrderListItemView extends StatelessWidget {
  OrderListItemView(
    this.order, {
    required this.index,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Order order;
  final int index;
  final void Function()? onTap;

  var textStyle = TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: const [
              Colors.orangeAccent,
              Colors.amberAccent,
            ],
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '> Buy',
                        style: Theme.of(context).textTheme.headline6,
                        // style: textStyle.copyWith(
                        //   fontWeight: FontWeight.bold,
                        // ),
                      ),
                      Text(
                        '#${order.id}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 12),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    '${order.coinAmount} BTC',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            20.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd HH:mm').format(order.date!),
                        style: Theme.of(context).textTheme.bodyText1!,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Paid:',
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        '\$${order.totalPaid}',
                        style: Theme.of(context).textTheme.bodyText1!,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
