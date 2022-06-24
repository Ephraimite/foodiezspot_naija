import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezspot_naija/components/reuseable_buttons.dart';
import 'package:foodiezspot_naija/screens/login_screen.dart';
import 'package:foodiezspot_naija/screens/sign_up_screen.dart';
import 'package:foodiezspot_naija/states/auth_state.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.srcATop),
                child: Image.asset(
                  'assets/images/image2.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 200, left: 10.0, right: 10.0, bottom: 20.0),
                      child: Text(
                        "Welcome to foodiespot naija",
                        style: TextStyle(fontFamily: 'Luckiest Guy',
                        fontSize: 40.0,
                        letterSpacing: 0.2,
                        color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: RoundedButton(text: 'Login',textColor: Colors.white,
                          buttonColor: kCOLOR_PRIMARY,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          }
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: RoundedButton(text: 'Sign up', textColor: kCOLOR_PRIMARY,
                          buttonColor: Colors.white,
                          onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  }

}
