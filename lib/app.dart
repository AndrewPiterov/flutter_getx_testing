import 'package:flutter/material.dart';
import 'package:flutter_getx_testing/shared/routing.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX Testing',
      debugShowCheckedModeBanner: false,
      // theme
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(),
        textTheme: const TextTheme(
          headline6: TextStyle(fontSize: 25.0, fontStyle: FontStyle.normal),
          bodyText2: TextStyle(
            fontSize: 16.0,
          ),
        ),
        // fontFamily:
      ),
      // routing
      initialRoute: AppRoutes.main,
      getPages: AppRouting.pages,
    );
  }
}
