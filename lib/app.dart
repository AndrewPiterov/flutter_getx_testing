import 'package:flutter/material.dart';
import 'package:flutter_getx_testing/shared/routing.dart';
import 'package:get/get.dart';

import 'services/services.dart';
import 'shared/shared.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          title: 'Flutter GetX Testing',
          debugShowCheckedModeBanner: false,
          // Theme
          themeMode: Get.find<IThemeService>().currentTheme,
          theme: MyThemes.light,
          darkTheme: MyThemes.dark,

          // Localization
          // translations: AppTranslations(),
          // locale: Get.deviceLocale,
          // fallbackLocale: const Locale('en', 'US'),

          // routing
          initialRoute: AppRoutes.main,
          getPages: AppRouting.pages,
        ));
  }
}
