import 'dart:async';
import 'package:flutter_getx_testing/models/pnl_calculator.dart';
import 'package:flutter_getx_testing/models/wallet.dart';
import 'package:flutter_getx_testing/services/coin_market_service.dart';
import 'package:flutter_getx_testing/services/orders_repository.dart';
import 'package:flutter_getx_testing/services/theme_service.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:speed_up_get/speed_up_get.dart';

abstract class IPortfolioSummaryViewController {
  double get marketValue;
  double get holdings;
  double get pnlValue;
  double get pnl;
  double get cost;

  Stream<PnlData> get pnlData$;

  bool get isDarkMode;

  Future refreshData();
}

class PortfolioSummaryViewController extends GetxController
    with GetxSubscribing
    implements IPortfolioSummaryViewController {
  PortfolioSummaryViewController(
    this._coinMarketService,
    this._ordersRepository,
    this._themeService,
  );

  final ICoinMarketService _coinMarketService;
  final IOrdersRepository _ordersRepository;
  final IThemeService _themeService;

  @override
  void onInit() {
    super.onInit();
    subscribe(
        CombineLatestStream.combine2<double, IInvestmentData, void>(
            _coinMarketService.currentCoinPrice$, _ordersRepository.stat$,
            (a, b) {
          final pnl = PnlCalculator().calculate(wallet: b, currentPrice: a);

          _holdings.value = b.coinAmount;
          _pnlValue.value = pnl.value;
          _pnl.value = pnl.percent;
          _cost.value = a;
          _marketvalue.value = pnl.holdingValue;
        }),
        (_) => _);
  }

  final _cost = 0.0.obs;
  @override
  double get cost => _cost.value;

  final _holdings = 0.0.obs;
  @override
  double get holdings => _holdings.value;

  final _marketvalue = 0.0.obs;
  @override
  double get marketValue => _marketvalue.value;

  final _pnl = 0.0.obs;
  @override
  double get pnl => _pnl.value;

  final _pnlValue = 0.0.obs;
  @override
  double get pnlValue => _pnlValue.value;

  @override
  bool get isDarkMode => _themeService.isDarkMode;

  @override
  Future refreshData() async {
    // TODO: implement
  }

  @override
  Stream<PnlData> get pnlData$ =>
      CombineLatestStream.combine2<double, IInvestmentData, PnlData>(
          _coinMarketService.currentCoinPrice$,
          _ordersRepository.stat$,
          (currentPrice, stats) => PnlCalculator()
              .calculate(wallet: stats, currentPrice: currentPrice));
}
