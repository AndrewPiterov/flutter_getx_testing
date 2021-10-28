import 'package:flutter_getx_testing/pages/main/wallet/widgets/portfolio_summary_view_controller.dart';
import 'package:flutter_getx_testing/services/orders_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart'
    hide when;
import 'package:mocktail/mocktail.dart';
import 'package:shouldly/shouldly.dart';

import '../mocks.dart';

void main() {
  test('Streaming pnl data when no investments', () {
    //
    final mockCoinMarketService = MockCoinMarketService();
    final mockRepo = MockOrderRepository();

    when(() => mockCoinMarketService.currentCoinPrice$)
        .thenAnswer((_) => Stream.fromIterable([10, 20, 30, 40, 50]));

    when(() => mockRepo.stat$).thenAnswer((_) => Stream.value(
          InvestmentData.empty,
        ));

    final controller = PortfolioSummaryViewController(
      mockCoinMarketService,
      mockRepo,
      MockThemeService(),
    );

    expect(controller.pnlData$.map((event) => event.percent),
        emitsInOrder([0, 0, 0, 0, 0]));
  });

  test('Streaming pnl data when invested', () {
    //
    final mockCoinMarketService = MockCoinMarketService();
    final mockRepo = MockOrderRepository();

    when(() => mockCoinMarketService.currentCoinPrice$)
        .thenAnswer((_) => Stream.fromIterable([10, 20, 30, 40, 50]));

    when(() => mockRepo.stat$).thenAnswer((_) => Stream.value(
          InvestmentData(coinAmount: 1, totalInvested: 10),
        ));

    final controller = PortfolioSummaryViewController(
        mockCoinMarketService, mockRepo, MockThemeService());

    expect(controller.pnlData$.map((event) => event.percent),
        emitsInOrder([0, 100, 200, 300, 400]));
  });

  given('Controller with Wallet and Coin market Price', () {
    //
    late PortfolioSummaryViewController controller;

    before(() {
      // Arrange
      final mockCoinMarketService = MockCoinMarketService();
      final mockRepo = MockOrderRepository();

      when(() => mockCoinMarketService.currentCoinPrice$)
          .thenAnswer((_) => Stream.fromIterable([20]));

      when(() => mockRepo.stat$).thenAnswer((_) =>
          Stream.value(InvestmentData(coinAmount: 1, totalInvested: 10)));

      controller = PortfolioSummaryViewController(
          mockCoinMarketService, mockRepo, MockThemeService());

      // Act
      controller.onInit();
      // await Future.delayed(Duration(milliseconds: 1));
    });

    then('holdings should be', () {
      // Assert
      controller.holdings.should.be(1);
    });

    then('Pnl Value should be', () {
      // Assert
      controller.pnlValue.should.be(10);
    });

    then('Pnl % should be', () {
      // Assert
      controller.pnl.should.be(100);
    });
  });
}
