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
  @override
  bool get isDarkMode => false;

  @override
  String get language => 'ru';

  @override
  void toggleDarkTheme(bool isOn) {
    // TODO: toggle dark theme
  }

  @override
  void changeLangugae(String lang) {
    // TODO: change language
  }

  @override
  void signOut() {
    // TODO: sign out
  }
}
