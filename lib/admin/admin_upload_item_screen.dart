
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodiezspot_naija/models/food_categories_data.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';

class AdminUpLoadItemScreen extends StatefulWidget {
  @override
  _AdminUpLoadItemScreenState createState() => _AdminUpLoadItemScreenState();
}

class _AdminUpLoadItemScreenState extends State<AdminUpLoadItemScreen> {
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodPriceController = TextEditingController();
  TextEditingController foodDecsController = TextEditingController();
  String foodID = DateTime.now().microsecondsSinceEpoch.toString();
  final _formKey = GlobalKey<FormState>();
  File? image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          backgroundColor: kCOLOR_PRIMARY_LIGHT,
          textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w200,
              fontFamily: 'Poppins'),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Card(
                        elevation: 6.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 3.0),
                          child: image != null
                              ? ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      height: 250, width: 300),
                                  child: Image.file(image!))
                              : ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      height: 250, width: 300),
                                  child: Image.asset(
                                      'assets/images/uploadImage.png')),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => getImage(),
                      child: Text(
                        'Select Image',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins-Regular'),
                      ),
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(15.0)),
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: categoryPicker()),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Pls type food name';
                                }
                              },
                              controller: foodNameController,
                              decoration: InputDecoration(
                                hintText: 'Food name',
                                fillColor: Colors.grey,
                              ),
                              cursorColor: kCOLOR_PRIMARY,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Item price cannot be empty';
                                }
                              },
                              controller: foodPriceController,
                              decoration: InputDecoration(
                                hintText: 'Price',
                                fillColor: Colors.grey,
                              ),
                              cursorColor: kCOLOR_PRIMARY,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Pls type item description';
                                }
                              },
                              controller: foodDecsController,
                              decoration: InputDecoration(
                                hintText: 'Description',
                                fillColor: Colors.grey,
                              ),
                              cursorColor: kCOLOR_PRIMARY,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 300, height: 50),
                      child: Builder(
                        builder: (context) => ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final progressBar = ProgressHUD.of((context));
                              progressBar!.showWithText("Uploading Item....");

                              if (image != null && selectedCategory != null) {
                                uploadItemImage(
                                    image,
                                    foodNameController.text,
                                    foodPriceController.text,
                                    foodDecsController.text,
                                    context);
                              }
                            }
                          },
                          child: Text(
                            'Upload item',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins-Regular'),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kCOLOR_PRIMARY),
                            elevation: MaterialStateProperty.all(6.0),
                          ),
                        ),
                      ),
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

  Future getImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (image == null) return;

      final imagePath = File(image.path);
      setState(() {
        this.image = imagePath;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget categoryPicker() {
    List<DropdownMenuItem<String>> dropDownItem = [];
    for (String category in categoryList) {
      var newItem = DropdownMenuItem(child: Text(category), value: category);
      dropDownItem.add(newItem);
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: DropdownButton<String>(
        hint: Text("Select food category"),
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.black87),
        underline: SizedBox(),
        iconSize: 36.0,
        isExpanded: true,
        value: selectedCategory,
        items: dropDownItem,
        onChanged: (value) {
          setState(
            () {
              selectedCategory = value!;
            },
          );
        },
      ),
    );
  }

   uploadItemImage(File? image, String foodName,
      String foodPrice, String foodDesc, BuildContext context) async {

     FirebaseStorage storage = FirebaseStorage.instance;
     String? url;
     Reference ref = storage.ref().child("Items").child("product_$foodID.jpg");
     UploadTask uploadTask = ref.putFile(image!);
     uploadTask.whenComplete(() async {
       url = await ref.getDownloadURL();
       await saveItemTOFirestore(foodName, foodPrice, foodDesc, context, url!);
       Fluttertoast.showToast(
           msg: "Item uploaded successfully",
           gravity: ToastGravity.CENTER,
         toastLength: Toast.LENGTH_LONG,
       );
       final progressBar = ProgressHUD.of(context);
       progressBar!.dismiss();
     }).catchError((onError) {
       Fluttertoast.showToast(
           msg: onError.toString(),
           toastLength: Toast.LENGTH_LONG,
           gravity: ToastGravity.CENTER);
       final progressBar = ProgressHUD.of(context);
       progressBar!.dismiss();
     });
     return url;

   }

  saveItemTOFirestore(String foodName, String foodPrice, String foodDesc,
      BuildContext context, String url) async {
    await FirebaseFirestore.instance.collection("Food items").doc(foodID).set({
      "imageUrl": url,
      "foodID": foodID,
      "foodCategory": selectedCategory,
      "foodName": foodName,
      "price": double.parse(foodPrice),
      "description": foodDesc,
    });
  }
}
