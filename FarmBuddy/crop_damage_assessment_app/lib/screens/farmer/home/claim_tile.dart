import 'dart:async';
import 'package:flutter/material.dart';
import 'package:crop_damage_assessment_app/models/claim.dart';

class ClaimTile extends StatelessWidget {
  final Claim? claim;
  const ClaimTile({Key? key, required this.claim}) : super(key: key);

  Future<Widget> getImage() async {
    final Completer<Widget> completer = Completer();
    var url = claim!.claim_image_urls[0];
    var image = NetworkImage(url);
    // final config = await image.obtainKey();
    final load = image.resolve(const ImageConfiguration());

    final listener = ImageStreamListener((ImageInfo info, isSync) async {
      if (info.image.width == 80 && info.image.height == 160) {
        completer.complete(const Text('AZAZA'));
      } else {
        completer.complete(Image(image: image, width: 400,));
      }
    });

    load.addListener(listener);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            Container(
              alignment: Alignment.center,
              height:200,
              child: FutureBuilder<Widget>(
                future: getImage(),
                builder: (context, claim_snapshot) {
                  if (claim_snapshot.hasData) {
                    return claim_snapshot.requireData;
                  } else {
                    return const Text('LOADING...');
                  }
                },
              ),
            ),

            ListTile(
              title: Text(claim!.claim_name),
              subtitle: Text("Crop Type - " + claim!.crop_type + "\nReason - " + claim!.reason),
              trailing: Text(claim!.status),
              onTap: () {
                print("aaaaaaaaaaaaaaa");
              },
            ),
          ],
        ),
      ),
    );
  }
}
