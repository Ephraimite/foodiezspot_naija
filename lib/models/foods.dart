
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Food{
  String? description;
  String? foodID;
  String? foodCategory;
  int? price;
  String? foodName;
  String? imageUrl;
  int cartItemQuantity = 0;



  Food({this.description, this.foodID, this.foodCategory, this.price,
    this.foodName, this.imageUrl, required this.cartItemQuantity});

  Food.fromMap(Map<String, dynamic> data){
    description = data['description'];
    foodID = data['foodID'];
    foodCategory = data['foodCategory'];
    foodName = data['foodName'];
    imageUrl = data['imageUrl'];
    price = data['price'].toInt();
  }
}