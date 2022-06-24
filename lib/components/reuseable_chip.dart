import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ReuseableChip extends StatelessWidget {

  final String text;
  final String? image;
  final bool isSelected;
  final Function(bool) onSelected;

  ReuseableChip({required this.text, this.image, required this.onSelected, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChoiceChip(
        label: Text(
          text,
          style: TextStyle(
            fontSize: 15.0,
            fontFamily: 'Poppins',
            color: isSelected == true? Colors.white : Colors.black,
          ),
        ),
        avatar: (image == null)? Container(): Image.asset(
          image!,
          width: 40,
          height: 40,
        ),
        elevation: 4,
        backgroundColor: Colors.white,
        labelPadding:
        EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
        selected: isSelected,
        selectedColor: kCOLOR_PRIMARY,
        onSelected: (value){
          onSelected(value);
        },
      ),
    );
  }
}
