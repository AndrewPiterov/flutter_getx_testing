import 'package:flutter_getx_testing/services/services.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get/get.dart';

class MockCoinMarketService extends GetxService
    with Mock
    implements ICoinMarketService {}

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

class MockThemeService extends GetxService with Mock implements IThemeService {}

class MyMocK {}
