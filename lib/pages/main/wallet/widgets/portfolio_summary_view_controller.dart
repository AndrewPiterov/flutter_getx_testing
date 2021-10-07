import 'dart:async';
import 'package:get/get.dart';

abstract class IPortfolioSummaryViewController {
  double get marketvalue;
  double get holdings;
  double get pnlValue;
  double get pnl;
  double get cost;

  Future refreshData();
}

class PortfolioSummaryViewController extends GetxController
    implements IPortfolioSummaryViewController {
  @override
  double get cost => 0;

  @override
  double get holdings => 0;

  @override
  double get marketvalue => 0;

  @override
  double get pnl => 0;

  @override
  double get pnlValue => 0;

  @override
  Future refreshData() async {
    // TODO: implement
  }
}
