import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_getx_testing/pages/order_detail/order_detail_page_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:speed_up_flutter/speed_up_flutter.dart';
import 'package:speed_up_get/speed_up_get.dart';

class OrderDetailPage extends GetView<OrderDetailPageController> {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: Obx(
        () {
          final order = c.order;
          if (c.order == null) {
            return SizedBox();
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transaction ID',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(order!.id.toString()),
                      ],
                    ),
                    10.w,
                    IconButton(onPressed: () {}, icon: Icon(Icons.copy)),
                  ],
                ),
                40.h,
                _rowData(context, 'Amount:',
                    '${order.coinAmount.toStringAsFixed(2)} BTC'),
                10.h,
                _rowData(context, 'Paid:',
                    '\$${order.totalPaid.toStringAsFixed(2)}'),
                10.h,
                _rowData(context, 'Date:',
                    DateFormat('yyyy-MM-dd HH:mm').format(order.date!)),
              ],
            ),
          );
        },
      ),
    );
  }

  Row _rowData(BuildContext context, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
