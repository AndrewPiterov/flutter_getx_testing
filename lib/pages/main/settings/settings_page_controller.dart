import 'dart:developer';
import 'dart:ui';

import 'package:flutter_getx_testing/pages/pages.dart';
import 'package:get/get.dart';

class SettingsPageController extends GetxController {
  bool get isDarkMode => false;

  final _language = 'en'.obs;

  String get language => _language.value;

  void toggleDarkTheme(bool isOn) => {};

  void changeLangugae(String lang) {
    log('Try to change locale to $lang');
    var locale =
        lang == 'ru' ? const Locale('ru', 'RU') : const Locale('en', 'US');
    Get.updateLocale(locale);
    _language.value = lang;
  }

  void signOut() {
    // Clear user account cachc
    Get.offAllNamed(AppRoutes.login);
  }
}
