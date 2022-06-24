import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:foodiezspot_naija/apis/food_api.dart';
import 'package:foodiezspot_naija/models/cart.dart';
import 'package:foodiezspot_naija/models/foods.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

import 'food_state_notifier.dart';

class CartState extends ChangeNotifier {
  Map<String, Food> _items = {};

  Map<String, Food> get items {
    return {..._items};
  }

  // get total items in cart
  int get itemCount {
    return _items.length;
  }

  // get total price of items
  int get totalAmount {
    var total = 0;
    _items
        .forEach((key, item) => total += (item.price! * item.cartItemQuantity));
    return total;
  }

  // add item to cart
  void addItem(String foodID, int price, String name, String image) {
    if (_items.containsKey(foodID)) {
      _items.update(
          foodID,
          (existingCartItem) => Food(
              foodName: existingCartItem.foodName,
              foodID: existingCartItem.foodID,
              price: existingCartItem.price,
              imageUrl: existingCartItem.imageUrl,
              cartItemQuantity: existingCartItem.cartItemQuantity + 1));
    } else {
      _items.putIfAbsent(
          foodID,
          () => Food(
              foodID: foodID,
              foodName: name,
              price: price,
              imageUrl: image,
              cartItemQuantity: 1));
    }
    notifyListeners();
  }

  // removes a single item from cart
  void removeItem(String foodID) {
    _items.remove(foodID);
    notifyListeners();
  }


  void removeSingleItem(String foodID) {
    if (!_items.containsKey(foodID)) {
      return;
    }
    if (_items[foodID]!.cartItemQuantity > 1) {
      _items.update(
          foodID,
          (existingCartItem) => Food(
                foodID: existingCartItem.foodID,
                foodName: existingCartItem.foodName,
                price: existingCartItem.price,
                imageUrl: existingCartItem.imageUrl,
                cartItemQuantity: -1,
              ));
    } else {
      _items.remove(foodID);
    }
    notifyListeners();
  }

  // clears all cart
  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
