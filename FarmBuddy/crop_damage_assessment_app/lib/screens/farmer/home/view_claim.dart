import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crop_damage_assessment_app/models/claim.dart';
import 'package:crop_damage_assessment_app/components/loading.dart';
import 'package:crop_damage_assessment_app/screens/farmer/home/claim_tile.dart';

class ViewClaim extends StatefulWidget {
  const ViewClaim({Key? key, required this.uid}) : super(key: key);

  final String? uid;

  @override
  _AddClaimState createState() => _AddClaimState();
}

class _AddClaimState extends State<ViewClaim> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final claims = Provider.of<List<Claim?>>(context);

    // claims.forEach((element) {
    //   print(element!.status);
    // });

    return loading
        ? const Loading()
        : Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: ListView.builder(
              itemCount: claims.length,
              itemBuilder: (context, index) {
                return ClaimTile(claim: claims[index]);
              },
            ));
  }
}
