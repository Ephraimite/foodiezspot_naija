
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodiezspot_naija/models/foods.dart';
import 'package:foodiezspot_naija/states/food_state_notifier.dart';


  getFoods(FoodNotifier foodNotifier) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('Food items');
    QuerySnapshot snapshot = await collectionReference.get();

    List<Food> _foodList = [];
    snapshot.docs.forEach((document) {
      Food food = Food.fromMap(document.data() as Map<String, dynamic>);
      _foodList.add(food);

    });

    foodNotifier.foodList = _foodList;

  }
