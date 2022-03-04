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

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  //verifyOTP
  Future verifyOTP(verificationID, optCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: optCode);
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

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
