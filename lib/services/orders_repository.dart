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

  Future<int> loadMoreOrders();

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

  @override
  void onInit() {
    super.onInit();
    unawaited(loadMoreOrders());
  }

  @override
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

  @override
  Future<ResultOf<Order>> save(Order order) async {
    // TODO: save in Firebase
    return ResultOf.success(order);
  }

  Future seedDb() async {
    final orders = <Order>[
      Order(coinAmount: 1, coinPrice: 0.01, date: DateTime(2010, 5)),
      Order(coinAmount: 1, coinPrice: 0.01, date: DateTime(2010, 5)),
      Order(coinAmount: 1, coinPrice: 1, date: DateTime(2011, 2)),
      Order(coinAmount: 1, coinPrice: 1, date: DateTime(2011, 2)),
      Order(coinAmount: 1, coinPrice: 1, date: DateTime(2011, 2)),
      Order(coinAmount: 1, coinPrice: 350, date: DateTime(2013, 9)),
      Order(coinAmount: 1, coinPrice: 1242, date: DateTime(2013, 10)),
      Order(coinAmount: 1, coinPrice: 500, date: DateTime(2014, 4)),
      Order(coinAmount: 1, coinPrice: 1290, date: DateTime(2017, 3)),
      Order(coinAmount: 1, coinPrice: 2000, date: DateTime(2017, 5)),
      Order(coinAmount: 1, coinPrice: 5000, date: DateTime(2017, 9)),
      Order(coinAmount: 1, coinPrice: 8000, date: DateTime(2017, 10)),
      Order(coinAmount: 1, coinPrice: 17000, date: DateTime(2017, 12, 15)),
      Order(coinAmount: 1, coinPrice: 19000, date: DateTime(2017, 12, 17)),
      Order(coinAmount: 1, coinPrice: 13800, date: DateTime(2017, 12, 22)),
      Order(coinAmount: 1, coinPrice: 6200, date: DateTime(2018, 2, 5)),
      Order(coinAmount: 1, coinPrice: 6300, date: DateTime(2018, 10, 31)),
      Order(coinAmount: 1, coinPrice: 3300, date: DateTime(2018, 12, 7)),
      Order(coinAmount: 1, coinPrice: 5000, date: DateTime(2020, 3, 16)),
      Order(coinAmount: 1, coinPrice: 10000, date: DateTime(2020, 7)),
      Order(coinAmount: 1, coinPrice: 19000, date: DateTime(2020, 11)),
      Order(coinAmount: 1, coinPrice: 41000, date: DateTime(2021, 1, 8)),
      Order(coinAmount: 1, coinPrice: 33400, date: DateTime(2021, 1, 11)),
      Order(coinAmount: 1, coinPrice: 44200, date: DateTime(2021, 2, 8)),
      Order(coinAmount: 1, coinPrice: 50000, date: DateTime(2021, 2, 16)),
      Order(coinAmount: 1, coinPrice: 60000, date: DateTime(2021, 4, 10)),
      Order(coinAmount: 1, coinPrice: 64000, date: DateTime(2021, 4, 14)),
      Order(coinAmount: 1, coinPrice: 30000, date: DateTime(2021, 5, 19)),
      Order(coinAmount: 1, coinPrice: 50000.128, date: DateTime(2021, 9, 2)),
      Order(coinAmount: 1, coinPrice: 62600, date: DateTime(2021, 10, 17)),
      Order(coinAmount: 1, coinPrice: 66974.77, date: DateTime(2021, 10, 20)),
    ];
    final wallet = Wallet(orders: orders);
    final stat = OrdersStat(wallet.coinAmount, wallet.totalInvested);

    // clear
    final items = await _firestore.collection('orders').get();
    for (var o in items.docs) {
      await _firestore.collection('orders').doc(o.id).delete();
    }

    // Save
    await _firestore.collection('stats').doc('1').set(
      {
        'coinAmount': stat.coinAmount,
        'totalInvested': stat.totalInvested,
      },
    );

    for (var o in orders) {
      await _firestore.collection('orders').add(o.asJson);
    }

    print('Success db seed 🎉');
  }
}
