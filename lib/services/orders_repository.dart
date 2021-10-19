import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluent_result/fluent_result.dart';
import 'package:flutter_getx_testing/models/models.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';
import 'package:speed_up_get/speed_up_get.dart';

class OrdersStat implements IInvestmentData {
  OrdersStat(this.coinAmount, this.totalInvested);

  @override
  final double coinAmount;

  @override
  final double totalInvested;
}

/// For fetching orders of coin
/// and saving new order
abstract class IOrdersRepository {
  Stream<List<Order>> get orders$;

  Stream<OrdersStat> get stat$;

  Future loadMoreOrders();

  Future<ResultOf<Order?>> save(Order order);
}

class FirebaseOrdersRepository extends GetxService
    with GetxSubscribing
    implements IOrdersRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _docs = BehaviorSubject<List<QueryDocumentSnapshot>>();

  static const _perPage = 10;

  @override
  Stream<List<Order>> get orders$ => _docs.map((docs) {
        final models = docs.map((e) {
          final timestamp = e['date'] as Timestamp;
          final date = timestamp.toDate();
          return Order(
            id: e.id,
            coinAmount: double.parse(e['amount'].toString()),
            coinPrice: double.parse(e['price'].toString()),
            date: date,
          );
        });

        return models.toList();
      });

  @override
  void onInit() {
    super.onInit();
    unawaited(loadMoreOrders());
  }

  @override
  Future loadMoreOrders() async {
    try {
      var q = _firestore
          .collection('orders')
          .orderBy('date', descending: true)
          .limit(_perPage);

      if (_docs.hasValue && _docs.value.isNotEmpty) {
        q = q.startAfterDocument(_docs.value.last);
      }

      final snapshots = await q.get();

      final newList =
          _docs.hasValue ? _docs.value.toList() : <QueryDocumentSnapshot>[];
      newList.addAll(snapshots.docs);
      _docs.add(newList);
      // log('Order count: ${_docs.value.length}');
      log('Order count: ${newList.length}');
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<ResultOf<Order>> save(Order order) async {
    // TODO: save in Firebase
    return ResultOf.success(order);
  }

  @override
  Stream<OrdersStat> get stat$ =>
      _firestore.collection('stats').doc('1').snapshots().map((event) {
        final data = event.data();
        if (data == null) {
          return OrdersStat(0, 0);
        }
        return OrdersStat(
          double.parse(data['coinAmount']?.toString() ?? '0'),
          double.parse(data['totalInvested']?.toString() ?? '0'),
        );
      });
}
