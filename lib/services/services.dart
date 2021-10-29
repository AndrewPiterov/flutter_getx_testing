import 'package:firebase_core/firebase_core.dart';

export './app_logger.dart';
export './firebase_orders_repo.dart';

Future initServices() async {
  await Firebase.initializeApp();
}
