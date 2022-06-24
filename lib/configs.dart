
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Configs{

  static SharedPreferences? prefs;
  static User? user;
  static FirebaseAuth? firebaseAuth;
  static FirebaseFirestore? firebaseFirestore;

}