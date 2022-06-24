import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodiezspot_naija/animations/custom_page_route.dart';
import 'package:foodiezspot_naija/components/reuseable_buttons.dart';
import 'package:foodiezspot_naija/constants.dart';
import 'package:foodiezspot_naija/controller/form_state.dart';
import 'package:foodiezspot_naija/screens/bottom_navigation.dart';
import 'package:foodiezspot_naija/screens/home_screen.dart';
import 'package:foodiezspot_naija/screens/sign_up_screen.dart';
import 'package:foodiezspot_naija/states/auth_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formKey = GlobalKey<FormState>();
  final  emailEditingController = TextEditingController();
  final  passwordEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: ProgressHUD(
          backgroundColor: kCOLOR_PRIMARY,

          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 70),
                    Icon(Icons.person_outlined, color: Colors.grey, size: 140),
                    SizedBox(height: 13),
                    Container(
                      child: TextFormField(
                        controller: emailEditingController,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Email cannot be empty';
                            }
                          },
                        enableSuggestions: true,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your email'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        controller: passwordEditingController,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'password cannot be empty';
                          }
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock, color: kCOLOR_PRIMARY),
                          labelText: 'Password',

                        ),
                        obscureText: true,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: kCOLOR_ACCENT,
                            ),
                            textAlign: TextAlign.end,

                          ),
                        ),
                      ],
                    ),
                    Builder(
                      builder: (BuildContext context) => RoundedButton(
                          text: 'Login',
                          textColor: kCOLOR_ACCENT,
                          buttonColor: kCOLOR_PRIMARY,
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              final progressBar = ProgressHUD.of((context));
                              progressBar!.showWithText("Authenticating pls wait....");
                                loginUser(emailEditingController.text, passwordEditingController.text, context);
                            }
                          }),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont have an account?',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(width: 10),
                        TextButton(
                          child: Text('Sign up',
                          style: TextStyle(
                            color: kCOLOR_PRIMARY,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          )
                          ), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp())),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser(String email, String password, BuildContext context) async {
    AuthenticationProvider authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    try{
      if(await authenticationProvider.loginUser(email, password)){
        final progressBar = ProgressHUD.of(context);
        progressBar!.dismiss();
    Navigator.push(context, CustomPageRoute(
        child: BottomNavigation(), direction: AxisDirection.left),);
    }else{
        Fluttertoast.showToast(
            msg: "An error occured pls try again",
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red);
        final progressBar = ProgressHUD.of(context);
        progressBar!.dismiss();

      }
    }catch(e){
    print(e);
    }

  }
}
