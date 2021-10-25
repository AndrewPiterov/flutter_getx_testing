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
        title: Text('orders'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Obx(
          () => ListView.separated(
            key: const ValueKey('order_list'),
            controller: c.scrollController,
            itemCount: c.orders.length + 1,
            separatorBuilder: (_, __) => 10.h,
            itemBuilder: (_, index) {
              if (index == c.orders.length) {
                return Obx(() {
                  return c.isBusyToFetcchNextPage.value
                      ? const Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : c.noMoreOreders.value
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'No more orders 🎉',
                                textAlign: TextAlign.center,
                              ),
                            )
                          : SizedBox();
                });
              }

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
