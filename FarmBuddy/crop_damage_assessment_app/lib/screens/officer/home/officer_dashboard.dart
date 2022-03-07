import 'package:flutter/material.dart';
import 'package:crop_damage_assessment_app/services/auth.dart';

class OfficerDashboard extends StatelessWidget {
  OfficerDashboard({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text('Farm Buddy - Officer Dashboard'),
        backgroundColor: const Color.fromARGB(255, 105, 184, 109),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('logout'),
              style: TextButton.styleFrom(
                primary: Colors.white, // foreground
              ),
              onPressed: () async {
                await _auth.signout();
              })
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          child: const Text('Make Claim'),
          onPressed: () async {},
        ),
      ),
    );
  }
}
