import 'package:fluent_result/fluent_result.dart';
import 'package:fluent_result/src/result_of.dart';
import 'package:flutter_getx_testing/models/order.dart';
import 'package:flutter_getx_testing/pages/main/order_list/order_list_page_controller.dart';
import 'package:flutter_getx_testing/services/services.dart';
import 'package:flutter_getx_testing/shared/routing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart'
    hide when;
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';
import 'package:shouldly/shouldly.dart';

import '../mocks.dart';

void main() {
  given('OrderListController', () {
    late IOrdersRepository mockRepo;
    late IDateTimeAdapter mockDateTimeAdapter;
    late INavigationService mockNavigator;
    late IToastrService mockToastrService;

    late OrderListPageController controller;

    before(() {
      mockRepo = MockOrderRepository();
      mockDateTimeAdapter = MockDateTimeAdapter();
      mockNavigator = MockNavigator();
      mockToastrService = MockToastrService();
    });

    after(() {
      Get.reset();
    });

    given('[with] order list', () {
      const orders = [
        Order(id: '1', coinAmount: 100, coinPrice: 100),
        Order(id: '2', coinAmount: 100, coinPrice: 100),
      ];

      late IOrdersRepository fakeOrderRepository;
      before(() {
        final repo = DummyOrdersRepository(orders);
        repo.onInit();
        fakeOrderRepository = repo;

        controller = OrderListPageController(
          fakeOrderRepository,
          mockDateTimeAdapter,
          mockNavigator,
          mockToastrService,
        );

        controller.onInit();
      });

      then('order list should be initializd', () {
        // expect(controller.orders, orders);
        controller.orders.should.be(orders);
      });

      whenn('pagination', () {
        before(() async {
          // Act
          await controller.loadMoreOrders();
          await Future.delayed(const Duration(milliseconds: 1));
        });

        then('new orders are loaded', () {
          // Assert
          // expect(controller.orders.length, greaterThan(orders.length));
          controller.orders.length.should.beGreaterThan(orders.length);
        });
      });
    });

    whenn('creating new order', () {
      const amount = 1000.0;
      const price = 7.0;
      final date = DateTime.now();

      setUp(() {
        when(() => mockDateTimeAdapter.now).thenReturn(date);

        controller = OrderListPageController(
          mockRepo,
          mockDateTimeAdapter,
          mockNavigator,
          mockToastrService,
        );
      });

      whenn('[with] succsess creating', () {
        // Arrange
        const newOrderId = '123';
        const newOrderDetailPageArgs = newOrderId; // {'id': newOrderId};

        setUp(() async {
          when(() => mockRepo.save(Order(
                coinAmount: amount,
                coinPrice: price,
                date: date,
              ))).thenAnswer((_) async => ResultOf.success(Order(
                id: newOrderId,
                coinAmount: amount,
                coinPrice: price,
                date: date,
              )));

          when(() => mockNavigator.goTo(AppRoutes.orderDetail,
              args: newOrderDetailPageArgs)).thenAnswer((_) => Future.value());

          await controller.save(amount, price);
        });

        then('repo saving was called', () async {
          // Assert
          verify(() => mockRepo.save(Order(
                coinAmount: amount,
                coinPrice: price,
                date: date,
              ))).called(1);
        });

        then('navigate to detail page', () async {
          // Assert

          verify(() => mockNavigator.goTo(
                AppRoutes.orderDetail,
                args: newOrderDetailPageArgs,
              )).called(1);
        });

        then('show success message', () async {
          // Assert
          verify(() => mockToastrService.success('Success')).called(1);
        });
      });

      whenn('[and] creation is failed', () {
        const errorMessage = 'could not create order';
        setUp(() async {
          // Arrange

          when(() => mockRepo.save(Order(
                    coinAmount: amount,
                    coinPrice: price,
                    date: date,
                  )))
              .thenAnswer((_) async => ResultOf.withErrorMessage(errorMessage));

          // Act
          await controller.save(amount, price);
        });

        then('repo save was called', () {
          verify(() => mockRepo.save(Order(
                coinAmount: amount,
                coinPrice: price,
                date: date,
              ))).called(1);
        });

        then('show error message', () {
          verify(() => mockToastrService.error(errorMessage)).called(1);
        });

        then('navigation to detail page was not called', () {
          verifyNever(() => mockNavigator.goTo(
                AppRoutes.orderDetail,
                args: any<String>(named: 'args'),
              ));
        });
      });
    });
  });
}

class DummyOrdersRepository extends GetxService implements IOrdersRepository {
  DummyOrdersRepository(this._orders);

  final List<Order> _orders;
  final List<Order> second = [
    Order(id: '3', coinAmount: 100, coinPrice: 100),
    Order(id: '4', coinAmount: 100, coinPrice: 100),
  ];

  final _orderSubject = BehaviorSubject<List<Order>>.seeded([]);

  @override
  Stream<List<Order>> get orders$ => _orderSubject;

  @override
  void onInit() {
    super.onInit();
    _orderSubject.add(_orders);
  }

  @override
  Future<int> loadMoreOrders() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final newList = _orderSubject.value.toList()..addAll(second);
    _orderSubject.add(newList);
    return second.length;
  }

  @override
  Future<ResultOf<Order>> save(Order order) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  // TODO: implement stat$
  Stream<OrdersStat> get stat$ => throw UnimplementedError();
}
