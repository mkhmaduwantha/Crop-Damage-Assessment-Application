import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_damage_assessment_app/models/claim.dart';
import 'package:crop_damage_assessment_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crop_damage_assessment_app/services/auth.dart';
import 'package:crop_damage_assessment_app/screens/farmer/home/add_claim.dart';
import 'package:crop_damage_assessment_app/screens/farmer/home/view_claim_list.dart';

class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({Key? key, required this.uid}) : super(key: key);

  final String? uid;

  @override
  _FarmerDashboardState createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  final AuthService _auth = AuthService();
  late DatabaseService db;

  void initFarmer() async {
    db = DatabaseService(uid: widget.uid);
    // db.select_uid = widget.uid;
    db.set_select_uid = widget.uid!;
    
  }

  @override
  void initState() {
    super.initState();
    initFarmer();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Claim?>>.value(
        value: db.farmerClaimList,
        initialData: const [],
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
              body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: const Text('Farm Buddy - Farmer Dashboard'),
                  backgroundColor: const Color.fromARGB(255, 105, 184, 109),
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  actions: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.power_settings_new),
                        onPressed: () async {
                          await _auth.signout();
                        })
                  ],
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    isScrollable: true,
                    indicatorPadding: const EdgeInsets.all(10),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: const Color.fromARGB(255, 74, 236, 128),
                    ),
                    tabs: const [
                      Tab(child: Text('View Claims')),
                      Tab(child: Text('Add Claim'))
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                ViewClaimList(uid: widget.uid),
                AddClaim(uid: widget.uid)
              ],
            ),
          )),
        ));
  }
}
