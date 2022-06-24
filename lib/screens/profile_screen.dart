import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodiezspot_naija/components/reuseable_app_bar.dart';
import 'package:foodiezspot_naija/components/reuseable_buttons.dart';
import 'package:foodiezspot_naija/components/reuseable_text_form_field.dart';
import 'package:foodiezspot_naija/constants.dart';
import 'package:foodiezspot_naija/models/users.dart';
import 'package:foodiezspot_naija/states/auth_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  UsersModel _usersModel = UsersModel();
  String photoID = DateTime.now().microsecondsSinceEpoch.toString();
  File? image;

  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();

  String? userImage;

  @override
  void initState() {
    super.initState();
    AuthenticationProvider _authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);

    _authenticationProvider.getUserDetails(_usersModel).then((value) {
      firstNameEditingController.text = _usersModel.firstName!;
      lastNameEditingController.text = _usersModel.lastName!;
      emailEditingController.text = _usersModel.email!;
      phoneEditingController.text = _usersModel.phone!.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    // userImage = _usersModel.profilePhoto;

    return SafeArea(
      child: Scaffold(
          key: _formKey,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: ReuseableAppBar(
                text: 'Edit Profile',
              )),
          body: ProgressHUD(
            backgroundColor: kCOLOR_PRIMARY_LIGHT,
            child: Container(
              padding: EdgeInsets.only(left: 15, top: 10, right: 15),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Consumer<AuthenticationProvider>(
                              builder: (BuildContext context, authState,
                                      Widget? child) =>
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: CircleAvatar(
                                      backgroundImage: authState.selectImage(
                                          _usersModel, image),
                                    ),
                                  )),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2.5,
                                  color: Colors.white,
                                ),
                                color: kCOLOR_PRIMARY,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, bottom: 8),
                                child: Builder(
                                  builder: (BuildContext context) => IconButton(
                                    onPressed: () {
                                      getImageFromGallery(context);
                                    },
                                    icon: Icon(Icons.add_a_photo,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    ReuseableTextFormField(
                      prefixIcon: Icon(
                        Icons.person,
                        color: kCOLOR_PRIMARY,
                      ),
                      controller: firstNameEditingController,
                      hintText: 'E.g tino dunfus',
                      inputType: TextInputType.name,
                      labelText: "First Name",
                    ),
                    ReuseableTextFormField(
                      prefixIcon: Icon(
                        Icons.person,
                        color: kCOLOR_PRIMARY,
                      ),
                      controller: lastNameEditingController,
                      hintText: 'E.g tino dunfus',
                      inputType: TextInputType.name,
                      labelText: "Last Name",
                    ),
                    ReuseableTextFormField(
                      prefixIcon: Icon(
                        Icons.email,
                        color: kCOLOR_PRIMARY,
                      ),
                      controller: emailEditingController,
                      hintText: 'E.g tinodunfus@gmail.com',
                      inputType: TextInputType.emailAddress,
                      labelText: "Email address",
                    ),
                    ReuseableTextFormField(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: kCOLOR_PRIMARY,
                      ),
                      controller: phoneEditingController,
                      hintText: 'E.g tino dunfus',
                      inputType: TextInputType.phone,
                      labelText: "Phone number",
                    ),
                    ReuseableTextFormField(
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: kCOLOR_PRIMARY,
                      ),
                      controller: addressEditingController,
                      hintText: 'E.g 11 havard street',
                      inputType: TextInputType.streetAddress,
                      labelText: "Address",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: RoundedButton(
                          onPressed: () {},
                          buttonColor: kCOLOR_PRIMARY,
                          text: 'Update Profile'),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future getImageFromGallery(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );

      if (image == null) return;

      final imagePath = File(image.path);
      setState(() {
        final progressBar = ProgressHUD.of((context));
        progressBar!.showWithText("Uploading....");
        this.image = imagePath;
        isLoading = true;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    uploadImageToStorage(image!, context);
  }

  uploadImageToStorage(File file, BuildContext context) {
    FirebaseStorage storage = FirebaseStorage.instance;
    String? url;
    Reference ref =
        storage.ref().child("Profile Image").child("profile_$photoID.jpg");
    UploadTask uploadTask = ref.putFile(image!);
    uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
      saveImageToFirestore(url!);
      Fluttertoast.showToast(
        msg: "Image uploaded successfully",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      final progressBar = ProgressHUD.of((context));
      progressBar!.dismiss();
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: onError.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
      final progressBar = ProgressHUD.of((context));
      progressBar!.dismiss();
    });
    return url;
  }

  saveItemTOFirestore(
      foodName, foodPrice, foodDesc, BuildContext context, String s) {}

  void saveImageToFirestore(String url) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser!.uid)
        .set({"Profile photo": url}, SetOptions(merge: true));

    // await FirebaseFirestore.instance
    //      .collection("Users")
    //      .doc(firebaseUser!.uid)
    //      .set(
    //     {"Profile photo": url}{(m)});
  }
}
