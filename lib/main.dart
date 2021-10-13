import 'package:flutter/material.dart';
import 'package:flutter_getx_testing/app.dart';
import 'package:flutter_getx_testing/services/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();

  runApp(const App());
}
