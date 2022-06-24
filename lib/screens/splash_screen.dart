import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:foodiezspot_naija/animations/custom_page_route.dart';
import 'package:foodiezspot_naija/constants.dart';
import 'package:foodiezspot_naija/screens/home_screen.dart';
import 'package:foodiezspot_naija/screens/login_screen.dart';
import 'package:foodiezspot_naija/screens/welcome_screen.dart';
import 'package:foodiezspot_naija/states/auth_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'introduction_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Image.asset('assets/images/logo.png'),
      ),
      backgroundColor: kCOLOR_PRIMARY_LIGHT,
      duration: 1200,
      animationDuration: Duration(seconds: 5),
      splashIconSize: double.infinity,
      splashTransition: SplashTransition.scaleTransition,
      nextScreen: Launch(),
    );
  }
}

class Launch extends StatefulWidget {
  @override
  _LaunchState createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    var email = prefs.getString('email');

    if (email != null) {
      return Navigator.pushReplacement(context,
          CustomPageRoute(child: HomeScreen(), direction: AxisDirection.left));
    } else if (_seen) {
      return Navigator.pushReplacement(context,
          CustomPageRoute(child: LoginScreen(), direction: AxisDirection.left));
    } else {
      // Set the flag to true at the end of onboarding screen if everything is successfull and so I am commenting it out
      await prefs.setBool('seen', true);
      return Navigator.pushReplacement(
          context,
          CustomPageRoute(
              child: OnboardingScreen(), direction: AxisDirection.left));
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
