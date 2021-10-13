import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class INavigationService {
  Future<dynamic> goTo(String routeName, {dynamic args});
  void back();
}

class GetXNavigationService extends GetxService implements INavigationService {
  @override
  Future goTo(String routeName, {args}) async {
    return Get.to(routeName, arguments: args);
  }

  @override
  void back() {
    Get.back();
  }
}

class NavigationService extends GetxService implements INavigationService {
  final GlobalKey navKey = GlobalKey();

  BuildContext get _context => navKey.currentState!.context;

  @override
  Future goTo(String routeName, {args}) async {
    return Navigator.pushNamed(
      _context,
      routeName,
      arguments: args,
    );
  }

  @override
  void back() {
    Navigator.pop(_context);
  }
}
