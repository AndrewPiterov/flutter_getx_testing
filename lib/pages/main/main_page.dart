import 'package:flutter/material.dart';

import 'order_list/order_list_page.dart';
import 'settings/settings_page.dart';
import 'wallet/wallet_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _tabPages = [
    const WalletPage(),
    const OrderListPage(),
    const SettingsPage(),
  ];

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: opentab,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet_giftcard),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              key: ValueKey('order_history_tab_button'),
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              key: ValueKey('settings_tab_button'),
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  void opentab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
