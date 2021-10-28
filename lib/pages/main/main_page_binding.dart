import 'package:flutter_getx_testing/services/date_time_adapter.dart';
import 'package:flutter_getx_testing/services/nav_service.dart';
import 'package:flutter_getx_testing/services/orders_repository.dart';
import 'package:flutter_getx_testing/services/toastr_service.dart';
import 'package:get/get.dart';

import 'order_list/order_list_page_controller.dart';
import 'settings/settings_page_controller.dart';
import 'wallet/widgets/portfolio_summary_view_controller.dart';

class MainPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IPortfolioSummaryViewController>(() =>
        PortfolioSummaryViewController(Get.find(), Get.find(), Get.find()));

    // Get.put(OrderListPageController(
    //   FirebaseOrdersRepository(),
    //   UtcDateTimeAdapter(),
    //   GetXNavigationService(),
    //   ToastrService(),
    // ));

    // Get.put(OrderListPageController(
    //   Get.find(),
    //   Get.find(),
    //   Get.find(),
    //   Get.find(),
    // ));

    Get.lazyPut<ISettingsPageController>(() => SettingsPageController());
  }
}
