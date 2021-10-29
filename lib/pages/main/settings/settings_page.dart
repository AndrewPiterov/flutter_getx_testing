import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_up_get/speed_up_get.dart';
import 'package:speed_up_flutter/speed_up_flutter.dart';

import 'settings_page_controller.dart';

class SettingsPage extends GetView<SettingsPageController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  c.isDarkMode ? 'dark_mode' : 'light_mode',
                  style: c.isDarkMode
                      ? const TextStyle(fontWeight: FontWeight.bold)
                      : null,
                ),
                Switch.adaptive(
                  // key: ValueKey('dark_theme_switch'),
                  value: c.isDarkMode,
                  onChanged: c.toggleDarkTheme,
                ),
              ],
            ),
            20.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('language'),
                if (c.language == 'en')
                  TextButton(
                    onPressed: () => c.changeLangugae('ru'),
                    child: const Text('English'),
                  ),
                if (c.language == 'ru')
                  TextButton(
                    onPressed: () => c.changeLangugae('en'),
                    child: const Text('Русский'),
                  ),
              ],
            ),
            20.h,
            OutlinedButton(
              onPressed: c.signOut,
              child: Text(
                'signout',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
