import 'dart:async';
import 'package:flutter_getx_testing/models/order.dart';
import 'package:flutter_getx_testing/models/pnl_calculator.dart';
import 'package:flutter_getx_testing/models/wallet.dart';
import 'package:flutter_getx_testing/services/coin_market_service.dart';
import 'package:flutter_getx_testing/services/orders_repository.dart';
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

  Future refreshData();
}

class PortfolioSummaryViewController extends GetxController
    with GetxSubscribing
    implements IPortfolioSummaryViewController {
  PortfolioSummaryViewController(
    this._coinMarketService,
    this._ordersRepository,
  );

  final ICoinMarketService _coinMarketService;
  final IOrdersRepository _ordersRepository;

  @override
  void onInit() {
    super.onInit();
    subscribe(
        CombineLatestStream.combine2<double, List<Order>, PnlData>(
            _coinMarketService.currentCoinPrice$,
            _ordersRepository.orders$,
            (a, b) => PnlCalculator.calculate(
                wallet: Wallet(orders: b), currentPrice: a)), (PnlData value) {
      _holdings.value = value.holdingValue;
      _pnlValue.value = value.value;
      _pnl.value = value.percent;
    });
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
  Future refreshData() async {
    // TODO: implement
  }

  @override
  Stream<PnlData> get pnlData$ =>
      CombineLatestStream.combine2<double, IInvestmentData, PnlData>(
          _coinMarketService.currentCoinPrice$,
          _ordersRepository.stat$,
          (currentPrice, stats) => PnlCalculator.calculate(
              wallet: stats, currentPrice: currentPrice));
}
