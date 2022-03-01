import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crop_damage_assessment_app/models/farmer.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  Farmer? _userFromFirebaseUser(User? user) {
    // ignore: unnecessary_null_comparison
    if (user != null) {
      return Farmer(uid: user.uid);
    } else {
      return null;
    }
  }

  //auth change user stream
  Stream<Farmer?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password

  //register with email & password

  //sign out
  Future signout() async {
    try {
      return await _auth.signOut();
      
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
