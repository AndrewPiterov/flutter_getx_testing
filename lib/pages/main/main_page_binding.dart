import 'package:get/get.dart';

import 'order_list/order_list_page_controller.dart';
import 'settings/settings_page_controller.dart';
import 'wallet/widgets/portfolio_summary_view_controller.dart';

class MainPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PortfolioSummaryViewController());
    Get.lazyPut(() => OrderListPageController());
    Get.lazyPut(() => SettingsPageController());
  }
}
