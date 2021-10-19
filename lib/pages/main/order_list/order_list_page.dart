import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_up_get/speed_up_get.dart';
import 'package:speed_up_flutter/speed_up_flutter.dart';

import 'order_list_page_controller.dart';
import 'widgets/order_list_item_vew.dart';

class OrderListPage extends GetView<OrderListPageController> {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Obx(
          () => ListView.separated(
            itemCount: c.orders.length,
            separatorBuilder: (_, __) => 10.h,
            itemBuilder: (_, index) {
              final order = c.orders[index];
              return Padding(
                padding: EdgeInsets.only(
                    top: index == 0 ? 20 : 0,
                    bottom: index == c.orders.length - 1 ? 20 : 0),
                child: OrderListItemView(
                  order,
                  index: index,
                  onTap: () => c.goToOrderDetail(order),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
