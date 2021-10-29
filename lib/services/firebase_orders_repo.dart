import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluent_result/fluent_result.dart';
import 'package:flutter_getx_testing/models/models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:speed_up_get/speed_up_get.dart';
import 'package:get/get.dart';

class FirebaseOrdersRepository extends GetxService with GetxSubscribing {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _docs = BehaviorSubject<List<QueryDocumentSnapshot>>();

  static const _perPage = 10;

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

  // TODO: Stream<InvestmentData> get stat$ =>
  //     _firestore.collection('stats').doc('1').snapshots().map((event) {
  //       final data = event.data();
  //       if (data == null) {
  //         return InvestmentData.empty;
  //       }
  //       return InvestmentData(
  //         coinAmount: double.parse(data['coinAmount']?.toString() ?? '0'),
  //         totalInvested: double.parse(data['totalInvested']?.toString() ?? '0'),
  //       );
  //     });

  @override
  void onInit() {
    super.onInit();
    unawaited(loadMoreOrders());
  }

  Future<int> loadMoreOrders() async {
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

      return snapshots.docs.length;
    } catch (e) {
      log(e.toString());
      return -1;
    }
  }

  Future<ResultOf<Order>> save(Order order) async {
    // TODO: save in Firebase
    return ResultOf.success(order);
  }
}
