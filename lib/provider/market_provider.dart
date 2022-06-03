import 'dart:async';

import 'package:cryptocurrency_tracker/models/cryptocurrency.dart';
import 'package:cryptocurrency_tracker/services/api_services.dart';
import 'package:cryptocurrency_tracker/services/local_storage.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider extends ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrency> markets = [];

  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> _markets = await API.getRequest();
    List<String> favorites = await LocalStorage.fetchFavorites();
    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJson(market);

      if (favorites.contains(newCrypto.id!)) {
        newCrypto.isFavorite = true;
      }
      temp.add(newCrypto);
    }
    markets = temp;
    isLoading = false;
    notifyListeners();
    Timer(const Duration(seconds: 3), () async {
      await fetchData();
    });
  }

  CryptoCurrency fetchCryptoById(String id) {
    CryptoCurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addFavorite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = true;
    await LocalStorage.addFavorite(crypto.id!);
    notifyListeners();
  }

  void removeFavorite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = false;
    await LocalStorage.removeFavorite(crypto.id!);
    notifyListeners();
  }
}
