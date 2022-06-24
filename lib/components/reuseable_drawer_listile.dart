import 'package:flutter/material.dart';
import 'package:foodiezspot_naija/screens/profile_screen.dart';

import '../constants.dart';

class ReuseableDrawerListTile extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Function()? onTap;


  ReuseableDrawerListTile({required this.iconData, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        iconData,
        color: kCOLOR_PRIMARY,
        size: 30,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 15,
        ),
      ),
    );
  }
}
