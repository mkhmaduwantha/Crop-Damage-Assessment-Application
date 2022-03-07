import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crop_damage_assessment_app/models/user.dart';
import 'package:crop_damage_assessment_app/models/farmer.dart';
import 'package:crop_damage_assessment_app/services/database.dart';
// import 'package:crop_damage_assessment_app/components/loading.dart';
import 'package:crop_damage_assessment_app/screens/farmer/add_data.dart';
import 'package:crop_damage_assessment_app/screens/admin/admin_dashboard.dart';
import 'package:crop_damage_assessment_app/screens/farmer/home/farmer_dashboard.dart';
import 'package:crop_damage_assessment_app/screens/officer/home/officer_dashboard.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Farmer?>(context);
    print('user ${user?.uid}');

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user?.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData? userData = snapshot.data;
          print('userData stream ${userData?.type}');

          switch (userData?.type) {
            case 'farmer':
              return FarmerDashboard(key: key);
            case 'officer':
              return OfficerDashboard(key: key);
            case 'admin':
              return AdminDashboard(key: key);
            default:
              return FarmerAddData(key: key);
          }
          
        } else {
          return FarmerAddData(key: key);
        }
      }
    );
  }
}
