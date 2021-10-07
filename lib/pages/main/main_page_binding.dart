import 'package:get/get.dart';

import 'order_history/order_history_page_controller.dart';
import 'settings/settings_page_controller.dart';
import 'wallet/widgets/portfolio_summary_view_controller.dart';

class MainPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IPortfolioSummaryViewController>(
        () => PortfolioSummaryViewController());
    Get.lazyPut<IOrderHistoryPageController>(
        () => OrderHistoryPageController());
    Get.lazyPut<ISettingsPageController>(() => SettingsPageController());
  }
}
