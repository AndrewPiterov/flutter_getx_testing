import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:speed_up_get/speed_up_get.dart';
import 'package:web_socket_channel/io.dart';

/// For real time updates for coin's market price
abstract class ICoinMarketService {
  Stream<double> get currentCoinPrice$;
}

class TickerPaylod {
  const TickerPaylod(this.price);

  final double price;

  static TickerPaylod fromJson(Map<String, dynamic> json) {
    return TickerPaylod(
      double.parse(json['c'].toString()),
    );
  }
}

class DummyCoinMarketService extends GetxService implements ICoinMarketService {
  @override
  Stream<double> get currentCoinPrice$ => const Stream.empty();
}

class BinanceCoinMarketService extends GetxService
    with GetxSubscribing
    implements ICoinMarketService {
  final _updates = BehaviorSubject<TickerPaylod>();
  @override
  Stream<double> get currentCoinPrice$ => _updates.map((event) => event.price);

  @override
  void onInit() {
    super.onInit();

    // Starts listetning market price of a coin
    unawaited(_listenCoinUpdates('BTC'));
  }

  Future _listenCoinUpdates(String symbol) async {
    final path = '${symbol.toLowerCase()}usdt@ticker';
    final uri = Uri.parse('wss://stream.binance.com:9443/ws/' + path);

    final channel = IOWebSocketChannel.connect(uri);
    subscribe(channel.stream, (value) {
      final val = value as String;
      final json = jsonDecode(val) as Map<String, dynamic>;
      final paylod = TickerPaylod.fromJson(json);
      _updates.add(paylod);
    });
  }
}
