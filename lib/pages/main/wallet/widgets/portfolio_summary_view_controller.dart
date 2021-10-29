import 'package:get/get.dart';

class PortfolioSummaryViewController extends GetxController {
  final _cost = 0.0.obs;
  double get cost => _cost.value;

  final _holdings = 0.0.obs;
  double get holdings => _holdings.value;

  final _marketvalue = 0.0.obs;
  double get marketValue => _marketvalue.value;

  final _pnl = 0.0.obs;
  double get pnl => _pnl.value;

  final _pnlValue = 0.0.obs;
  double get pnlValue => _pnlValue.value;
}
