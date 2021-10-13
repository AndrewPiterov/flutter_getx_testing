import 'package:fluent_result/fluent_result.dart';
import 'package:fluent_result/src/result_of.dart';
import 'package:flutter_getx_testing/models/order.dart';
import 'package:flutter_getx_testing/pages/main/order_list/order_list_page_controller.dart';
import 'package:flutter_getx_testing/services/services.dart';
import 'package:flutter_getx_testing/shared/routing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';
import 'package:shouldly/shouldly.dart';

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
  Future loadMoreOrders() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final newList = _orderSubject.value.toList()..addAll(second);
    _orderSubject.add(newList);
  }

  @override
  Future<ResultOf<Order>> save(Order order) {
    // TODO: implement save
    throw UnimplementedError();
  }
}

class MockOrderRepository extends GetxService
    with Mock
    implements IOrdersRepository {}

class MockDateTimeAdapter extends GetxService
    with Mock
    implements IDateTimeAdapter {}

class MockNavigator extends GetxService
    with Mock
    implements INavigationService {}

class MockToastrService extends GetxService
    with Mock
    implements IToastrService {}

void main() {
  late IOrdersRepository mockRepo;
  late IDateTimeAdapter mockDateTimeAdapter;
  late INavigationService mockNavigator;
  late IToastrService mockToastrService;

  setUp(() {
    mockRepo = MockOrderRepository();
    mockDateTimeAdapter = MockDateTimeAdapter();
    mockNavigator = MockNavigator();
    mockToastrService = MockToastrService();
  });

  tearDown(() {
    Get.reset();
  });

  group('OrderListPage Controller', () {
    test('Initital list', () async {
      // Arrange
      const orders = [
        Order(id: '1', coinAmount: 100, coinPrice: 100),
        Order(id: '2', coinAmount: 100, coinPrice: 100),
      ];

      final fakeOrderRepository = DummyOrdersRepository(orders);
      fakeOrderRepository.onInit();

      // Act
      final controller = OrderListPageController(
        fakeOrderRepository,
        mockDateTimeAdapter,
        mockNavigator,
        mockToastrService,
      );
      controller.onInit();

      await Future.delayed(const Duration(milliseconds: 1));

      // Assert
      expect(controller.orders, orders);
    });

    test('Successful Pagination', () async {
      // Arrange
      const orders = [
        Order(id: '1', coinAmount: 100, coinPrice: 100),
        Order(id: '2', coinAmount: 100, coinPrice: 100),
      ];

      final fakeOrderRepository = DummyOrdersRepository(orders);
      fakeOrderRepository.onInit();

      // Act
      final controller = OrderListPageController(
        fakeOrderRepository,
        mockDateTimeAdapter,
        mockNavigator,
        mockToastrService,
      );
      controller.onInit();

      // await Future.delayed(const Duration(milliseconds: 1));

      await controller.loadMoreOrders();
      await Future.delayed(const Duration(milliseconds: 1));

      // Assert
      expect(controller.orders.length, greaterThan(orders.length));
    });

    test('Create new Order', () async {
      // Arrange
      const amount = 1000.0;
      const price = 7.0;
      const newOrderId = '123';

      const newOrderDetailPageArgs = newOrderId; // {'id': newOrderId};

      final date = DateTime.now();
      when(() => mockDateTimeAdapter.now).thenReturn(date);

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

      final controller = OrderListPageController(
        mockRepo,
        mockDateTimeAdapter,
        mockNavigator,
        mockToastrService,
      );

      // Act
      await controller.save(amount, price);

      // Assert
      verify(() => mockRepo.save(Order(
            coinAmount: amount,
            coinPrice: price,
            date: date,
          ))).called(1);

      verify(() => mockNavigator.goTo(
            AppRoutes.orderDetail,
            args: newOrderDetailPageArgs,
          )).called(1);

      verify(() => mockToastrService.success('Success')).called(1);
    });

    test('Failed Creating new Order', () async {
      // Arrange
      const amount = 1000.0;
      const price = 7.0;
      const newOrderId = '123';

      const newOrderDetailPageArgs = newOrderId; // {'id': newOrderId};

      const errorMessage = 'could not create order';

      final date = DateTime.now();
      when(() => mockDateTimeAdapter.now).thenReturn(date);

      when(() => mockRepo.save(Order(
            coinAmount: amount,
            coinPrice: price,
            date: date,
          ))).thenAnswer((_) async => ResultOf.withErrorMessage(errorMessage));

      when(() => mockNavigator.goTo(AppRoutes.orderDetail,
          args: newOrderDetailPageArgs)).thenAnswer((_) => Future.value());

      final controller = OrderListPageController(
        mockRepo,
        mockDateTimeAdapter,
        mockNavigator,
        mockToastrService,
      );

      // Act
      await controller.save(amount, price);

      // Assert
      verify(() => mockRepo.save(Order(
            coinAmount: amount,
            coinPrice: price,
            date: date,
          ))).called(1);

      verify(() => mockToastrService.error(errorMessage)).called(1);

      verifyNever(() => mockNavigator.goTo(
            AppRoutes.orderDetail,
            args: newOrderDetailPageArgs,
          ));
    });

    // test('Open New Order', () {
    //   final controller = OrderListPageController();
    //   //controller.orders.
    // });
  });
}
