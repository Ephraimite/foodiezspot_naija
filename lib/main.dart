import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodiezspot_naija/admin/admin_dashboard.dart';
import 'package:foodiezspot_naija/admin/admin_upload_item_screen.dart';
import 'package:foodiezspot_naija/screens/bottom_navigation.dart';
import 'package:foodiezspot_naija/screens/cart_screen.dart';
import 'package:foodiezspot_naija/screens/home_screen.dart';
import 'package:foodiezspot_naija/screens/splash_screen.dart';
import 'package:foodiezspot_naija/states/auth_state.dart';
import 'package:foodiezspot_naija/states/cart_state_notifier.dart';
import 'package:foodiezspot_naija/states/food_state_notifier.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> AuthenticationProvider(),),
        ChangeNotifierProvider(
          create: (_) => FoodNotifier(),
        ),
        ChangeNotifierProvider(create: (_)=> CartState(),),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        theme: ThemeData(
          primaryColor: kCOLOR_PRIMARY,
        ),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
