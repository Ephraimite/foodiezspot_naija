import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezspot_naija/constants.dart';
import 'package:foodiezspot_naija/screens/login_screen.dart';
import 'package:foodiezspot_naija/screens/welcome_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Foodiespot_naija',
              body: 'Your favourite online food plug',
              image: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 100.0, left: 20.0, right: 20.0),
                  child: Image.asset('assets/images/meals.png'),
                ),
              ),
            ),
            PageViewModel(
              title: 'Fast Delivery',
              body: 'Firsthand superfast delivery',
              image: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 100.0, left: 20.0, right: 20.0),
                  child: Image.asset('assets/images/delivery.png'),
                ),
              ),
            ),
            PageViewModel(
              title: 'Easy Payment',
              body: 'Secure payment solution with the best payment gateway',
              image: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 100.0, left: 20.0, right: 20.0),
                  child: Image.asset('assets/images/payments.png'),
                ),
              ),
            ),
          ],
          showDoneButton: true,
          showSkipButton: true,
          showNextButton: true,
          done: Container(
            decoration: BoxDecoration(
              color: Color(0xfff09419),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Get started',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onDone: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          skip: Text(
            'Skip',
            style: TextStyle(
              color: kCOLOR_PRIMARY,
              fontWeight: FontWeight.bold,
            ),
          ),
          onSkip: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          next: Icon(
            Icons.arrow_forward,
            color: kCOLOR_PRIMARY,
          ),
          globalBackgroundColor: Colors.grey[200],
          dotsDecorator: DotsDecorator(
              activeColor: kCOLOR_PRIMARY,
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              activeSize: Size(20.0, 10.0)),
        ),
      );
}
