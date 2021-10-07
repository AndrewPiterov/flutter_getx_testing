import 'package:get/get.dart';

/// For real time updates for coin's market price
abstract class ICoinMarketService {
  Stream<double> get currentCoinPrice$;
}

class CoinMarketService extends GetxService implements ICoinMarketService {
  @override
  Stream<double> get currentCoinPrice$ => const Stream.empty();
}
