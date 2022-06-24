import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodiezspot_naija/components/reuseable_buttons.dart';
import 'package:foodiezspot_naija/constants.dart';
import 'package:foodiezspot_naija/models/foods.dart';
import 'package:foodiezspot_naija/states/cart_state_notifier.dart';
import 'package:provider/provider.dart';

class ItemDetails extends StatefulWidget {
  final Food foods;

  ItemDetails({required this.foods});

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int _currentCount = 1;

  @override
  Widget build(BuildContext context) {
    CartState foodStore = Provider.of<CartState>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kCOLOR_PRIMARY,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: 60.0, bottom: 30.0, left: 30.0, right: 30.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: 350,
                    height: 300,
                  ),
                  child: Image(
                    image: NetworkImage(widget.foods.imageUrl!),
                    // fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 20, left: 20, bottom: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        widget.foods.foodName!,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.foods.description!),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '₦ ${widget.foods.price!}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: RoundedButton(
                            onPressed: () {
                              foodStore.addItem(
                                  widget.foods.foodID!,
                                  widget.foods.price!,
                                  widget.foods.foodName!,
                                  widget.foods.imageUrl!);

                              Fluttertoast.showToast(
                                  msg: "Item Added to cart",
                                  toastLength: Toast.LENGTH_LONG,
                                  backgroundColor: kCOLOR_PRIMARY,
                                  gravity: ToastGravity.CENTER,
                                  fontSize: 16,
                                  textColor: Colors.white);
                            },
                            text: 'Add to cart',
                            buttonColor: kCOLOR_PRIMARY,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Widget _createIncrementDicrementButton(IconData icon, Function onPressed) {
//   return RawMaterialButton(
//     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//     constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
//     onPressed: () {},
//     elevation: 2.0,
//     fillColor: kCOLOR_LIGHT_GREY,
//     child: Icon(
//       icon,
//       color: Colors.black,
//       size: 12.0,
//     ),
//     shape: CircleBorder(),
//   );
// }
//
// _dicrement() {}
//
// _increment() {}
}
