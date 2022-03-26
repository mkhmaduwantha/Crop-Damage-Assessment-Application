import 'package:crop_damage_assessment_app/screens/farmer/home/claim_profile.dart';
import 'package:crop_damage_assessment_app/screens/farmer/home/claim_view.dart';
import 'package:crop_damage_assessment_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:crop_damage_assessment_app/models/claim.dart';
import 'package:crop_damage_assessment_app/models/user.dart';
import 'package:crop_damage_assessment_app/services/auth.dart';

class ClaimPanel extends StatefulWidget {
  const ClaimPanel({Key? key, required this.claim}) : super(key: key);

  final Claim? claim;

  @override
  _ClaimPanelState createState() => _ClaimPanelState();
}

class _ClaimPanelState extends State<ClaimPanel> {
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
              title: const Text('View Claim'),
              backgroundColor: const Color.fromARGB(255, 105, 184, 109),
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
                  Tab(child: Text('Claim')),
                  Tab(child: Text('Personal'))
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            ClaimView(claim: widget.claim),
            ClaimProfile(uid: widget.claim!.uid, claim_uid: widget.claim!.uid)
          ],
        ),
      )),
    );
  }
}