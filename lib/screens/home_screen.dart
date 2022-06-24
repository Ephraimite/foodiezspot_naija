import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezspot_naija/apis/food_api.dart';
import 'package:foodiezspot_naija/components/Navigation_drawer.dart';
import 'package:foodiezspot_naija/components/reuseable_chip.dart';
import 'package:foodiezspot_naija/components/reuseable_home_cards.dart';
import 'package:foodiezspot_naija/components/reuseable_home_text.dart';
import 'package:foodiezspot_naija/constants.dart';
import 'package:foodiezspot_naija/models/food_categories_data.dart';
import 'package:foodiezspot_naija/models/users.dart';
import 'package:foodiezspot_naija/states/auth_state.dart';
import 'package:foodiezspot_naija/states/cart_state_notifier.dart';
import 'package:foodiezspot_naija/states/food_state_notifier.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _choiceIndex = 0;
  UsersModel _usersModel = UsersModel();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    AuthenticationProvider _authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    _authenticationProvider.getUserDetails(_usersModel);
  }

  @override
  Widget build(BuildContext context) {
    CartState foodStore = Provider.of<CartState>(context, listen: false);
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 70,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Badge(
                showBadge: foodStore.itemCount > 0,
                position: BadgePosition(top: 0, end: 2),
                animationType: BadgeAnimationType.scale,
                badgeContent: Text(
                  foodStore.itemCount.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  color: kCOLOR_PRIMARY,
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 35.0,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            icon: Icon(
              Icons.menu,
              size: 40.0,
              color: kCOLOR_PRIMARY,
            ),
          ),
        ),
        drawer: Drawer(
          child: MainDrawer(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeScreentext(
                          text: ('Hello, ${_usersModel.firstName}'),
                          textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 24.0),
                        ),
                        SizedBox(height: 5),
                        HomeScreentext(
                          text: ('What do you want today?'),
                          textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 85.0),
                      child: Container(
                        width: 50,
                        height: 50,
                        child: CircleAvatar(

                          radius: 20.0,
                          backgroundImage: _usersModel.profilePhoto == null
                              ? AssetImage('assets/images/personImage.jpg')
                              : NetworkImage(_usersModel.profilePhoto!)
                                  as ImageProvider,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: kCOLOR_PRIMARY,
                        decoration: kInputTextFieldDecoration,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                        child: Image.asset(
                      'assets/images/filter_image.png',
                      width: 40,
                      height: 40,
                    )),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Poppins-Bold',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  height: 70,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: categoryListData.length,
                      itemBuilder: (context, index) {
                        return ReuseableChip(
                          text: categoryListData[index].text,
                          image: categoryListData[index].image,
                          isSelected: _choiceIndex == index,
                          onSelected: (bool value) {
                            setState(() {
                              _choiceIndex = value ? index : 0;
                            });
                          },
                        );
                      }),
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return FoodHomeCard(
                      title: foodNotifier.foodList[index].foodName!,
                      price: foodNotifier.foodList[index].price!,
                      image: foodNotifier.foodList[index].imageUrl!,
                      description: foodNotifier.foodList[index].description,
                      foodID: foodNotifier.foodList[index].foodID,
                      foodCategory: foodNotifier.foodList[index].foodCategory,
                      quantity: foodNotifier.foodList[index].cartItemQuantity,

                      // description: foodNotifier.foodList[index].description!,
                    );
                  },
                  itemCount: foodNotifier.foodList.length,
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FoodNotifier foodNotifier =
        Provider.of<FoodNotifier>(context, listen: false);
    getFoods(foodNotifier);
  }
}
