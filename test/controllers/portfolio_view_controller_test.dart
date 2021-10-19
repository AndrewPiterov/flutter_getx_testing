import 'package:flutter_getx_testing/models/order.dart';
import 'package:flutter_getx_testing/pages/main/wallet/widgets/portfolio_summary_view_controller.dart';
import 'package:flutter_getx_testing/services/orders_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shouldly/shouldly.dart';
import '../given_when_then.dart';

import '../mocks.dart';

void main() {
  test('Streaming pnl data when no investments', () {
    //
    final mockCoinMarketService = MockCoinMarketService();
    final mockRepo = MockOrderRepository();

    when(() => mockCoinMarketService.currentCoinPrice$)
        .thenAnswer((_) => Stream.fromIterable([10, 20, 30, 40, 50]));

    when(() => mockRepo.stat$).thenAnswer((_) => Stream.value(
          OrdersStat(0, 0),
        ));

    final controller =
        PortfolioSummaryViewController(mockCoinMarketService, mockRepo);

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
          OrdersStat(1, 10),
        ));

    final controller =
        PortfolioSummaryViewController(mockCoinMarketService, mockRepo);

    expect(controller.pnlData$.map((event) => event.percent),
        emitsInOrder([0, 100, 200, 300, 400]));
  });

  given('Controller with Wallet and Coin market Price', body: () {
    //
    late PortfolioSummaryViewController controller;

    setUp(() {
      // Arrange
      final mockCoinMarketService = MockCoinMarketService();
      final mockRepo = MockOrderRepository();

      when(() => mockCoinMarketService.currentCoinPrice$)
          .thenAnswer((_) => Stream.fromIterable([20]));

      when(() => mockRepo.orders$).thenAnswer((_) => Stream.value([
            Order(coinAmount: 1, coinPrice: 10),
          ]));

      controller =
          PortfolioSummaryViewController(mockCoinMarketService, mockRepo);

      // Act
      controller.onInit();
      // await Future.delayed(Duration(milliseconds: 1));
    });

    then('holdings should be', () {
      // Assert
      controller.holdings.should.be(20);
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
