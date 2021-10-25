import 'dart:developer';
import 'dart:ui';

import 'package:flutter_getx_testing/services/services.dart';
import 'package:flutter_getx_testing/shared/shared.dart';
import 'package:get/get.dart';

abstract class ISettingsPageController {
  bool get isDarkMode;
  String get language;

  void toggleDarkTheme(bool isOn);
  void changeLangugae(String lang);
  void signOut();
}

class SettingsPageController extends GetxController
    implements ISettingsPageController {
  SettingsPageController({ThemeService? themeService})
      : _themeService = themeService ?? Get.find();

  final IThemeService _themeService;

  @override
  bool get isDarkMode => _themeService.isDarkMode;

  final _language = 'en'.obs;

  @override
  String get language => _language.value;

  @override
  void toggleDarkTheme(bool isOn) => _themeService.setDarkModeOn(isOn);

  @override
  void changeLangugae(String lang) {
    log('Try to change locale to $lang');
    var locale =
        lang == 'ru' ? const Locale('ru', 'RU') : const Locale('en', 'US');
    Get.updateLocale(locale);
    _language.value = lang;
  }

  @override
  void signOut() {
    // Clear user account cachc
    Get.offAllNamed(AppRoutes.login);
  }
}
