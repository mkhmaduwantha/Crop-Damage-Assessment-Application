import 'package:flutter/material.dart';
import 'package:crop_damage_assessment_app/services/auth.dart';

class Home extends StatelessWidget {
  
  Home({ Key? key }) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text('Farm Buddy - Home'),
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person), 
            label: const Text('logout'),
            onPressed: () async{
              await _auth.signout();
            }

          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          child: const Text('Make Claim'),
          onPressed: () async {
          },
        ),
      ),
    );
  }
}