import 'package:flutter_getx_testing/pages/pages.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const main = '/main';
  static const login = '/login';
  static const orderDetail = '/orderDetail';
}

class AppRouting {
  static final pages = [
    GetPage(
      name: AppRoutes.main,
      page: () => const MainPage(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.orderDetail,
      page: () => const OrderDetailPage(),
      binding: OrderDetailBindings(),
    ),
  ];
}
