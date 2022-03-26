import 'package:crop_damage_assessment_app/components/loading.dart';
import 'package:crop_damage_assessment_app/models/user.dart';
import 'package:crop_damage_assessment_app/services/database.dart';
import 'package:flutter/material.dart';

UserData? user;

class ClaimProfile extends StatefulWidget {
  final String? uid;
  final String? claim_uid;

  const ClaimProfile({Key? key, required this.uid, required this.claim_uid})
      : super(key: key);

  @override
  _ClaimProfileState createState() => _ClaimProfileState();
}

class _ClaimProfileState extends State<ClaimProfile> {

  bool loading = true;

  void getData() async {
    //use a Async-await function to get the data
    final select_user = await DatabaseService(uid: widget.uid).getUserData(widget.claim_uid);
    setState(() {
      user = select_user;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return loading
        ? const Loading()
        : Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              alignment: Alignment.center,
              child: Text(user!.uid),
            ),
          );
  }
}
