import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:foodiezspot_naija/screens/profile_screen.dart';
import 'package:foodiezspot_naija/screens/transaction_history_screen.dart';
import 'package:foodiezspot_naija/screens/wallet_screen.dart';
import 'package:ionicons/ionicons.dart';

import '../constants.dart';
import 'home_screen.dart';

class BottomNavigation extends StatefulWidget {

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {

    final bottomNavigationScreens =[
      HomeScreen(),
      ProfileScreen(),
      WalletScreen(),
      TransactionHistory(),
    ];

    void _onItemTap(int index){
      setState(() {
        _currentIndex = index;
      });
    }

    return Scaffold(
      body: PageTransitionSwitcher(
          duration: Duration(milliseconds: 1000),
          transitionBuilder: (Widget child, Animation<double> primaryAnimation,
              Animation<double> secondaryAnimation) =>
              FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              ),
          child: bottomNavigationScreens[_currentIndex]
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTap,
        elevation: 16,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home_outline),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.person_outline),
            label: 'Profile',

          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.wallet_outline),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.refresh_outline),
            label: 'Transactions',
          ),
          ],
        selectedItemColor: kCOLOR_PRIMARY,
      ),
    );
  }
}
