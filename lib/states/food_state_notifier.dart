
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodiezspot_naija/models/foods.dart';

class FoodNotifier with ChangeNotifier{


  List<Food> _foodList = [];
  late Food _currentFood;

  UnmodifiableListView<Food> get foodList => UnmodifiableListView(_foodList);

  Food get currentFood => _currentFood;

  set foodList(List<Food> foodList){
    _foodList = foodList;
    notifyListeners();
  }

  set currentFood(Food food){
    _currentFood = food;
    notifyListeners();
  }


}