import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:crop_damage_assessment_app/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text('Sign In to Farm Buddy'),
        backgroundColor: Colors.green[400],
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          child: const Text('Sign In Anon'),
          onPressed: () async {
            dynamic result = await _auth.signAnonymously();
            if (result == null) {
              print('error signing in');
            } else {
              print('signed in');
              print('Result ${result.uid}');
            }
          },
        ),
      ),
    );
  }
}
