import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezspot_naija/animations/custom_page_route.dart';
import 'package:foodiezspot_naija/models/foods.dart';
import 'package:foodiezspot_naija/screens/item_details_screen.dart';

class FoodHomeCard extends StatelessWidget {
  final String image;
  final String title;
  final String? description;
  final int? price;
  final String? foodID;
  final String? foodCategory;
  final int quantity;

  FoodHomeCard(
      {required this.image,
      required this.title,
      required this.price,
      this.description,
      this.foodID,
      this.foodCategory,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CustomPageRoute(
            child: ItemDetails(
              foods: Food(
                  foodName: title,
                  price: price,
                  description: description,
                  imageUrl: image,
                  foodCategory: foodCategory,
                  foodID: foodID,
                  cartItemQuantity: quantity),
            ),
            direction: AxisDirection.left
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10),
        clipBehavior: Clip.antiAlias,
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(
                child: Image(
                  image: NetworkImage(image),
                  fit: BoxFit.fitWidth,
                  height: 150,
                  width: 200,
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600),
            ),
            // Text(description),
            Text(
              '₦ $price',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
