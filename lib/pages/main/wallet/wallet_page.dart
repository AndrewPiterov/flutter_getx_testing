import 'package:flutter/material.dart';

import 'widgets/portfolio_summary_view.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: PortfolioSummaryView(),
          ),
        ],
      ),
    );
  }
}
