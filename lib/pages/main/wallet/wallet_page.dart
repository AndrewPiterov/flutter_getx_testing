import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_up_flutter/speed_up_flutter.dart';

import 'widgets/portfolio_summary_view.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('wallet'),
      ),
      body: Column(
        children: [
          (Get.height / 12).h,
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Image.asset('assets/img/btc.png'),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: PortfolioSummaryView(),
          ),
        ],
      ),
    );
  }
}
