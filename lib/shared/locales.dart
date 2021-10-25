import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'wallet': 'Wallet',
          'orders': 'Orders',
          'settings': 'Settings',
          'dark_mode': 'Dark Mode',
          'light_mode': 'Light Mode',
          'language': 'Language',
          'signout': 'Sign Out',
        },
        'ru_RU': {
          'wallet': 'Кошелёк',
          'orders': 'Покупки',
          'settings': 'Настройки',
          'dark_mode': 'Теёмная тема',
          'light_mode': 'Светлая тема',
          'language': 'Язык',
          'signout': 'Выйти',
        }
      };
}
