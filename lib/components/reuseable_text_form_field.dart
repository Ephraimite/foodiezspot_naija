

import 'package:flutter/material.dart';

import '../constants.dart';

class ReuseableTextFormField extends StatelessWidget {
  final TextInputType inputType;
  final TextEditingController controller;
  final String hintText;
  final Icon prefixIcon;
  final String labelText;
  final String? initialValue;

  ReuseableTextFormField(
      {required this.inputType,
        required this.controller,
        required this.hintText,
        required this.prefixIcon,
        required this.labelText, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15, bottom: 20),
      child: TextFormField(
        cursorColor: kCOLOR_PRIMARY,
        controller: controller,
        keyboardType: inputType,
        initialValue: initialValue,
        validator: (value) {
          if (value!.isEmpty) {
            return 'This field is required';
          }
        },
        decoration: kTextFieldDecoration.copyWith(
            hintText: hintText, prefixIcon: prefixIcon, labelText: labelText),
      ),

    );
  }
}