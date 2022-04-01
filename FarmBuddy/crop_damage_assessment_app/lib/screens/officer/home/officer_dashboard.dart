import 'package:crop_damage_assessment_app/screens/officer/home/view_claim_list.dart';
import 'package:crop_damage_assessment_app/screens/officer/home/filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crop_damage_assessment_app/models/claim.dart';
import 'package:crop_damage_assessment_app/services/auth.dart';
import 'package:crop_damage_assessment_app/services/database.dart';

class OfficerDashboard extends StatefulWidget {
  const OfficerDashboard({Key? key, required this.uid, required this.filter}) : super(key: key);

  final String? uid;
  // ignore: prefer_typing_uninitialized_variables
  final filter;

  @override
  _OfficerDashboardState createState() => _OfficerDashboardState();
}

class _OfficerDashboardState extends State<OfficerDashboard> {
  final AuthService _auth = AuthService();
  late DatabaseService db;

  void initOfficerClaimList() async {
    db = DatabaseService(uid: widget.uid);
    db.set_select_uid = widget.uid!;

  }

  void _showSettingsPanel() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            padding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Filter(uid: widget.uid, filter: widget.filter),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    initOfficerClaimList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Claim?>>.value(
      value: db.officerClaimList(widget.filter["claim_state"], widget.filter["agrarian_division"]),
      initialData: const [],
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    title: const Text('Farm Buddy - Officer'),
                    backgroundColor: const Color.fromARGB(255, 105, 184, 109),
                    elevation: 0.0,
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () => _showSettingsPanel(),
                      ),
                      IconButton(
                          icon: const Icon(Icons.power_settings_new),
                          onPressed: () async {
                            await _auth.signout();
                          }),
                    ],
                    pinned: true,
                    floating: true),
              ];
            },
            body: ViewClaimList(uid: widget.uid)
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 105, 184, 109),
                ),
                child: Text('Farm Buddy'),
              ),
              ListTile(
                title: const Text('Edit Profile'),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => FarmerEditData(uid: widget.uid)),
                  // );
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () async {
                  await _auth.signout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
