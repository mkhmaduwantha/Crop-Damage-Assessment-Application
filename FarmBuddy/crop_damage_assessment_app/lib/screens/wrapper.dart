import 'package:crop_damage_assessment_app/models/farmer.dart';

import 'farmer/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Farmer?>(context);
    print('user ${user}');

    //retunr either Home/Authenticate widget
    if(user == null){
      return Authenticate(key: key);
    }else{
      return Home(key: key);
    }
    
  }
}
