import 'package:get/get.dart';

import 'order_list/order_list_page_controller.dart';
import 'settings/settings_page_controller.dart';
import 'wallet/widgets/portfolio_summary_view_controller.dart';

class MainPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IPortfolioSummaryViewController>(
        () => PortfolioSummaryViewController(Get.find(), Get.find()));
    Get.lazyPut(() => OrderListPageController(
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
        ));
    Get.lazyPut<ISettingsPageController>(() => SettingsPageController());
  }
}
