

import 'package:flutter/material.dart';

import '../constants.dart';

class ReuseableAppBar extends StatelessWidget {
  final IconData? iconButton;
  final String? text;

  ReuseableAppBar({this.iconButton, this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: kCOLOR_PRIMARY),
      title: Text(text!),
      actions: [
        IconButton(
          color: kCOLOR_PRIMARY,
          onPressed: () {},
          icon: Icon(iconButton, size: 34, color: kCOLOR_PRIMARY),
        ),
      ],
    );
  }
}