import 'package:flutter/material.dart';

class HomeScreentext extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  HomeScreentext({required this.text, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text( text,
      style: textStyle,
    );
  }
}
