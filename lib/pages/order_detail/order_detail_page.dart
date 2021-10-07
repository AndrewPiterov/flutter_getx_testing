import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_getx_testing/models/models.dart';
import 'package:get/get.dart';
import 'package:speed_up_flutter/speed_up_flutter.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments as Order;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Order detail ${order.id}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
            40.h,
            Text(
              'Bitcoins: ${order.coinAmount}',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'Paid: \$${order.totalPaid}',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'Date: ${order.date.toIso8601String()}',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
