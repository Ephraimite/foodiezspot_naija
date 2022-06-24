import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const String USER_FIRST_NAME = 'firstName';
const String USER_LAST_NAME = 'lastName';
const String USER_EMAIL = 'email';
const String USER_PHONE = 'phone';
const String USER_UID = 'uid';
const String USER_ADDRESS = 'userAddress';
const String USER_CART_LIST = 'cartList';
const String USER_PASSWORD = 'password';

const String PRODUCT_ID = 'uid';
const String PRODUCT_DETAILS = 'productDetails';
const String ORDER_TIME = 'orderTime';


const kCOLOR_PRIMARY = Color(0xfff09419);
const kCOLOR_ACCENT = Color(0xff471924);
const kCOLOR_PRIMARY_LIGHT = Color(0xffedaa53);
const kCOLOR_LIGHT_GREY = Color(0xffececec);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your password.',
  labelText: 'Email',
  prefixIcon: Icon(Icons.email, color: kCOLOR_PRIMARY),

  labelStyle: TextStyle(
    color: kCOLOR_ACCENT,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kCOLOR_PRIMARY),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const kInputTextFieldDecoration = InputDecoration(
  prefixIcon: Icon(Icons.search, color: Colors.grey),
  filled: true,
  focusColor: kCOLOR_PRIMARY,
  fillColor: kCOLOR_LIGHT_GREY,
  hintText: 'search',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide.none,
  ),

);