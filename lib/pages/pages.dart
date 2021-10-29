export './login/login_page.dart';
export './main/main_page.dart';
export './main/main_page_binding.dart';
export './order_detail/order_detail_page.dart';
export './order_detail/bindings.dart';
import 'package:get/get.dart';

import 'login/login_page.dart';
import 'main/main_page.dart';
import 'main/main_page_binding.dart';
import 'order_detail/bindings.dart';
import 'order_detail/order_detail_page.dart';

class AppRoutes {
  static const main = '/main';
  static const login = '/login';
  static const orderDetail = '/orderDetail';
}

final pages = [
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
