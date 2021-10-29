import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/pages.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX Testing',
      debugShowCheckedModeBanner: false,
      // routing
      initialRoute: AppRoutes.main,
      getPages: pages,
    );
  }
}
