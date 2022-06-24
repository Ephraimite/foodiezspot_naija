import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezspot_naija/constants.dart';
import 'package:foodiezspot_naija/states/cart_state_notifier.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String image;
  final String foodName;
  final int price;
  final String foodID;
  final String? foodCategory;
  final String? description;
  final int quantity;
  final Function()? reduceItemQuantity;
  final Function()? increaseItemQuantity;

  CartItem(
      {required this.image,
      required this.foodName,
      required this.price,
      required this.foodID,
      this.foodCategory,
      this.description,
      required this.quantity,
      this.reduceItemQuantity,
      this.increaseItemQuantity, required this.id});

  @override
  Widget build(BuildContext context) {
    CartState foodStore = Provider.of<CartState>(context, listen: false);

    return Card(
      margin: EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      key: ValueKey(id),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(image),
              height: 80,
              width: 100,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodName,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    price.toString(),
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    child: Container(
                      color: kCOLOR_LIGHT_GREY,
                      width: 110,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                reduceItemQuantity!();
                              },
                              icon: Icon(
                                Icons.remove_circle,
                                color: kCOLOR_PRIMARY_LIGHT,
                              )),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                increaseItemQuantity!();
                              },
                              icon: Icon(
                                Icons.add_circle,
                                color: kCOLOR_PRIMARY_LIGHT,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  color: Colors.red,
                  icon: Icon(
                    Icons.delete,
                  ),
                  onPressed: () {

                    Provider.of<CartState>(context, listen: false).removeItem(foodID);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
