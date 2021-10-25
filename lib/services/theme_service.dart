import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class IThemeService {
  ThemeMode get currentTheme;

  bool get isDarkMode;

  void setDarkModeOn(bool isOn);
}

class ThemeService extends GetxService implements IThemeService {
  final _currentTheme = ThemeMode.system.obs;

  @override
  ThemeMode get currentTheme => _currentTheme.value;

  final _isDarkMode = false.obs;

  @override
  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    _isDarkMode.value = _currentTheme.value == ThemeMode.dark;
  }

  @override
  void setDarkModeOn(bool isOn) {
    _currentTheme.value = isOn ? ThemeMode.dark : ThemeMode.light;
    _isDarkMode.value = isOn;
  }
}
