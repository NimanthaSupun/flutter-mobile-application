import 'package:datashare2/models/cart_model.dart';
import 'package:flutter/material.dart';

class CardProvider extends ChangeNotifier {
  Map<String, CartItem> _items = {};

  // getter
  Map<String, CartItem> get items {
    return {..._items};
  }

  // add item
  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
      print("add existing data");
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: 1,
        ),
      );
      print("add new Data");
    }
    notifyListeners();
  }
  // remove from card

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // remove single item form card
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingCardItem) => CartItem(
          id: existingCardItem.id,
          title: existingCardItem.title,
          price: existingCardItem.price,
          quantity: existingCardItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  // clear all

  void clearAll() {
    _items = {};
    notifyListeners();
  }

  // calculate total

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    notifyListeners();
    return total;
  }
}
