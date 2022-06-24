import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodiezspot_naija/animations/custom_page_route.dart';
import 'package:foodiezspot_naija/components/reuseable_drawer_listile.dart';
import 'package:foodiezspot_naija/configs.dart';
import 'package:foodiezspot_naija/constants.dart';
import 'package:foodiezspot_naija/screens/cart_screen.dart';
import 'package:foodiezspot_naija/screens/login_screen.dart';
import 'package:foodiezspot_naija/screens/profile_screen.dart';
import 'package:foodiezspot_naija/screens/transaction_history_screen.dart';
import 'package:foodiezspot_naija/screens/wallet_screen.dart';
import 'package:foodiezspot_naija/states/auth_state.dart';
import 'package:ionicons/ionicons.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  AuthenticationProvider _authenticationProvider = AuthenticationProvider();
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/personImage.png'),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Username",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Poppins'),
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        //Now let's Add the button for the Menu
        //and let's copy that and modify it
        ReuseableDrawerListTile(
          text: 'Edit Profile',
          iconData: Ionicons.person,
          onTap: (){
            Navigator.pop(context);
            Navigator.push(
              context,
                CustomPageRoute(
                    child: ProfileScreen(), direction: AxisDirection.left)
            );
          },
        ),
        ReuseableDrawerListTile(
          iconData: Ionicons.wallet,
          text: 'Wallet',
          onTap: (){
            Navigator.pop(context);
            Navigator.push(
              context,
                CustomPageRoute(
                    child: WalletScreen(), direction: AxisDirection.left)
            );
          },
        ),
        ReuseableDrawerListTile(
          iconData: Ionicons.cart,
          text: 'Cart',
          onTap: (){
            Navigator.pop(context);
            Navigator.push(
              context,
                CustomPageRoute(
                    child: CartScreen(), direction: AxisDirection.left)
            );
          },
        ),
        ReuseableDrawerListTile(
          iconData: Ionicons.refresh,
          text: 'Transaction History',
          onTap: (){
            Navigator.pop(context);
            Navigator.push(
              context,
                CustomPageRoute(
                    child: TransactionHistory(), direction: AxisDirection.left),
            );
          },
        ),
        Divider(
          height: 30,
          thickness: 5.0,
        ),
        ReuseableDrawerListTile(
          iconData: Ionicons.log_out,
          text: 'Logout',
          onTap: () {
            _authenticationProvider.signOut().then((value){
              Navigator.pop(context);
              Navigator.pushReplacement(context, CustomPageRoute(
                  child: LoginScreen(), direction: AxisDirection.left));
            });
          },
        ),
      ],
    );
  }
}
