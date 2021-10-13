import 'package:get/get.dart';

abstract class IDateTimeAdapter {
  DateTime get now;
}

class UtcDateTimeAdapter extends GetxService implements IDateTimeAdapter {
  @override
  DateTime get now => DateTime.now().toUtc();
}

class LocalDateTimeAdapter extends GetxService implements IDateTimeAdapter {
  @override
  DateTime get now => DateTime.now();
}
