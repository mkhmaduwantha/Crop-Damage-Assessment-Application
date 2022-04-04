import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crop_damage_assessment_app/models/user.dart';
import 'package:crop_damage_assessment_app/models/user_auth.dart';
import 'package:crop_damage_assessment_app/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crop_damage_assessment_app/screens/farmer/add_farmer.dart';
import 'package:crop_damage_assessment_app/screens/admin/admin_dashboard.dart';
import 'package:crop_damage_assessment_app/screens/farmer/home/farmer_dashboard.dart';
import 'package:crop_damage_assessment_app/screens/officer/home/officer_dashboard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {

  void initHome() async {
    print("init officer");
    final preference = await SharedPreferences.getInstance();
    await preference.setString("claim_state", "Pending");
    await preference.setString("agrarian_division", "galle");
  }

  @override
  void initState() {
    super.initState();
    initHome();
  }

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
                return OfficerDashboard(uid: user_auth?.uid);

              case 'admin':
                return AdminDashboard(key: widget.key);

              default:
                return FarmerAddData(
                    uid: user_auth?.uid, phone_no: user_auth?.phone_no);
            }
          } else {
            return FarmerAddData(
                uid: user_auth?.uid, phone_no: user_auth?.phone_no);
          }
        });
  }
}
