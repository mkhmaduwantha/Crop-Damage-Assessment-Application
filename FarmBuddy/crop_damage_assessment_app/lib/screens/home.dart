import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crop_damage_assessment_app/models/user.dart';
import 'package:crop_damage_assessment_app/models/user_auth.dart';
import 'package:crop_damage_assessment_app/services/database.dart';
// import 'package:crop_damage_assessment_app/components/loading.dart';
import 'package:crop_damage_assessment_app/screens/farmer/add_farmer.dart';
import 'package:crop_damage_assessment_app/screens/admin/admin_dashboard.dart';
import 'package:crop_damage_assessment_app/screens/farmer/home/farmer_dashboard.dart';
import 'package:crop_damage_assessment_app/screens/officer/home/officer_dashboard.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user_auth = Provider.of<UserAuth?>(context);
    print('user ${user_auth?.uid}');

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user_auth?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? user = snapshot.data;
            print('userData stream ${user?.type}');

            switch (user?.type) {
              case 'farmer':
                return FarmerDashboard(uid: user_auth?.uid);
              case 'officer':

                var filter = {"claim_state" : "Pending", "agrarian_division": "galle"};
                return OfficerDashboard(uid: user_auth?.uid, filter: filter );
              case 'admin':
                return AdminDashboard(key: key);
              default:
                return FarmerAddData(uid: user_auth?.uid, phone_no: user_auth?.phone_no);
            }
          } else {
            return FarmerAddData(uid: user_auth?.uid, phone_no: user_auth?.phone_no);
          }
        });
  }
}
