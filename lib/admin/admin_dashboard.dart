import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezspot_naija/admin/admin_upload_item_screen.dart';
import 'package:foodiezspot_naija/components/reuseable_admin_card.dart';
import 'package:foodiezspot_naija/constants.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin Dashboard', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AdminReuseableCard(
                      icon: Icons.shop_2,
                      iconSize: 100.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminUpLoadItemScreen()),);
                },
                child: Text(
                  'Add item',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18.0,
                      fontFamily: 'Poppins-Regular'),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kCOLOR_PRIMARY_LIGHT),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
