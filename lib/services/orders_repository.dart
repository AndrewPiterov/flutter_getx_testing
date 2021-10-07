import 'package:flutter_getx_testing/models/models.dart';
import 'package:flutter_getx_testing/shared/extensions.dart';
import 'package:get/get.dart';

/// For fetching order history of coin
abstract class IOrdersRepository {
  Stream<List<Order>> get orders$;
}

class OrdersRepository extends GetxService implements IOrdersRepository {
  @override
  Stream<List<Order>> get orders$ =>
      Stream.value(20.generate((index) => randomOrder(index)).toList());
}
