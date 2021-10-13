import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_getx_testing/services/nav_service.dart';
import 'package:flutter_getx_testing/services/toastr_service.dart';
import 'package:get/get.dart';

import 'coin_market_service.dart';
import 'date_time_adapter.dart';
import 'orders_repository.dart';

export 'coin_market_service.dart';
export 'date_time_adapter.dart';
export 'nav_service.dart';
export 'orders_repository.dart';
export 'toastr_service.dart';

Future initServices() async {
  await Firebase.initializeApp();

  Get.put<IDateTimeAdapter>(UtcDateTimeAdapter());
  Get.put<IToastrService>(ToastrService());
  Get.put<INavigationService>(GetXNavigationService());
  Get.put(FirebaseOrdersRepository());
  Get.put<ICoinMarketService>(DummyCoinMarketService());
}
