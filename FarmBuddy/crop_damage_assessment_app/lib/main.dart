import 'package:flutter/material.dart';
import 'package:crop_damage_assessment_app/screens/wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmy Buddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Wrapper(key: key),
    );
  }
}
