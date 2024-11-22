import 'package:flutter/material.dart';

class FavProvider extends ChangeNotifier {
// state
  final Map<String, bool> _fav = {};

  // getter

  Map<String, bool> get fav => _fav;

  // method for add item toggle

  void toggleFav(String productId) {
    if (_fav.containsKey(productId)) {
      _fav[productId] = !_fav[productId]!;
    } else {
      _fav[productId] = true;
    }
    notifyListeners();
  }

  // method to checl weather fav or not

  bool isFav(String productId) {
    return _fav[productId] ?? false;
  }
}
