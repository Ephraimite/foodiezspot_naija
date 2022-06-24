import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodiezspot_naija/models/users.dart';

class AuthenticationProvider with ChangeNotifier {
  String? _uid;
  String? _email;

  String? get getUid => _uid;

  String? get getEmail => _email;

  final userRef = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> get getCurrentUser async {
    user = _auth.currentUser;
  }

  Future<void> signOut() async {
    _auth.signOut();
  }

  Future<bool> signUpUser(String email, String password) async {
    bool value = false;

    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (_authResult.user != null) {
        _uid = _authResult.user!.uid;
        _email = _authResult.user!.email;
        value = true;
      }
    } on FirebaseException catch (error) {
      print(error);
    }
    return value;
  }

  Future<bool> loginUser(String email, String password) async {
    bool value = false;

    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_authResult.user != null) {
        _uid = _authResult.user!.uid;
        _email = _authResult.user!.email;
        return true;
      }
    } on FirebaseException catch (error) {
      print(error);
    }

    return value;
  }

  Future getUserDetails(UsersModel usersModel) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    await userRef.doc(firebaseUser!.uid).get().then((value) {
      // print(value.data()!['name']);
      usersModel.firstName = value.data()!['firstName'];
      usersModel.lastName = value.data()!['lastName'];
      usersModel.email = value.data()!['email'];
      usersModel.phone = value.data()!['phone'];
      usersModel.profilePhoto = value.data()!['Profile photo'];
    }).catchError((onError) {
      print(onError);
    });
    notifyListeners();
  }

  selectImage(UsersModel usersModel, File? image) {
    print(" this is an image $image");
    return image != null
        ? FileImage(image)
        : usersModel.profilePhoto != null
            ? NetworkImage(usersModel.profilePhoto!)
            : AssetImage('assets/images/personImage.png');
  }
}
