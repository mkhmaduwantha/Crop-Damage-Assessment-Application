import 'package:flutter/material.dart';
import 'package:crop_damage_assessment_app/services/auth.dart';
import 'package:crop_damage_assessment_app/screens/farmer/home/add_claim.dart';

class FarmerDashboard extends StatelessWidget {
  FarmerDashboard({Key? key, required this.uid}) : super(key: key);

final String? uid;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
               SliverAppBar(
                title: const Text('Farm Buddy - Farmer Dashboard'),
                backgroundColor:const Color.fromARGB(255, 105, 184, 109),
                elevation: 0.0,
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
                    Tab(child: Text('View Claim')),
                    Tab(child: Text('Add Claim'))
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              const Icon(Icons.directions_transit, size: 350),
              AddClaim(uid: uid)
            ],
          ),
      )),
    );
  }
}

