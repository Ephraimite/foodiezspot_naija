import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezspot_naija/components/reuseable_app_bar.dart';
import 'package:foodiezspot_naija/components/reuseable_buttons.dart';
import 'package:foodiezspot_naija/components/reuseable_cart_items.dart';
import 'package:foodiezspot_naija/constants.dart';
import 'package:foodiezspot_naija/states/cart_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

class CartScreen extends StatelessWidget {
  final int deliveryFee = 1000;
  final formatter = intl.NumberFormat.decimalPattern();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CartState>(
        builder: (BuildContext context, foodStore, Widget? child) => Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Badge(
                      showBadge: foodStore.itemCount > 0,
                      position: BadgePosition(top: 0, end: 2),
                      animationType: BadgeAnimationType.scale,
                      badgeContent: Text(
                        foodStore.itemCount.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                  child: ReuseableAppBar(text: 'Cart',iconButton: Icons.shopping_cart,)),
              ),
            ),
          body: foodStore.items.isEmpty
              ? Container(
                  child: Center(
                      child: Text(
                    'No items in cart',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  )),
                )
              : Column(
                  children: [
                    InkWell(
                      child: Text(
                        'Delete all items',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      onTap: () => foodStore.clearCart(),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return CartItem(
                            image: foodStore.items.values
                                .toList()[index]
                                .imageUrl!,
                            price:
                                foodStore.items.values.toList()[index].price!,
                            foodName: foodStore.items.values
                                .toList()[index]
                                .foodName!,
                            foodID:
                                foodStore.items.values.toList()[index].foodID!,
                            quantity: foodStore.items.values
                                .toList()[index]
                                .cartItemQuantity,
                            increaseItemQuantity:
                                increaseItemQuantity(index, foodStore),
                            reduceItemQuantity:
                                reducetItemQuantity(index, foodStore),
                            id: foodStore.items.keys.toList()[index],
                          );
                        },
                        itemCount: foodStore.items.length,
                        shrinkWrap: true,
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          height: 180, width: double.infinity),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Item Total'),
                                Text(
                                    "₦ ${formatter.format(foodStore.totalAmount)}"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Delivery fee',
                                  style: TextStyle(
                                      fontSize: 14.0, fontFamily: 'Poppins'),
                                ),
                                Text(
                                  '₦ ${formatter.format(deliveryFee)}',
                                  style: TextStyle(
                                      fontSize: 14.0, fontFamily: 'Poppins'),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Amount',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '₦ ${formatter.format(foodStore.totalAmount + deliveryFee)}',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            RoundedButton(
                              onPressed: checkOutItems,
                              text: 'Checkout items',
                              buttonColor: kCOLOR_PRIMARY,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  increaseItemQuantity(int index, CartState foodStore) {}

  reducetItemQuantity(int index, CartState foodStore) {}

  checkOutItems() {}
}

