import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:speed_up_flutter/speed_up_flutter.dart';
import 'package:speed_up_get/speed_up_get.dart';

import 'portfolio_summary_view_controller.dart';

class PortfolioSummaryView extends GetView<PortfolioSummaryViewController> {
  const PortfolioSummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _value(
                    title: 'Market Value',
                    value: '\$${c.marketValue.toStringAsFixed(2)}',
                  ),
                ),
                Container(
                  width: 2,
                  height: 70,
                  color: Colors.grey,
                ),
                Expanded(
                  child: _value(
                    title: 'Holdings',
                    value: '${c.holdings.toStringAsFixed(2)} BTC',
                  ),
                ),
              ],
            ),
            Container(
              // width: 2,
              height: 2,
              color: Colors.grey,
              child: const Center(),
            ),
            Row(
              children: [
                Expanded(
                  child: _value(
                    title: 'Profit/Loss',
                    value: '+ \$${c.pnlValue.toStringAsFixed(2)}',
                    additional: Text(
                      '+ ${c.pnl.toStringAsFixed(2)}%',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  height: 70,
                  color: Colors.grey,
                ),
                Expanded(
                  child: _value(title: 'Cost', value: '\$${c.cost}'),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _value({
    required String title,
    required String value,
    Widget? additional,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          7.h,
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              additional ?? const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
