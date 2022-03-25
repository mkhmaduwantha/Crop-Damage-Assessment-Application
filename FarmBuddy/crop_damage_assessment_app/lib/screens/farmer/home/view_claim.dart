import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_damage_assessment_app/models/claim.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:crop_damage_assessment_app/models/claim.dart';

import 'package:crop_damage_assessment_app/services/auth.dart';
import 'package:crop_damage_assessment_app/services/database.dart';
import 'package:crop_damage_assessment_app/components/loading.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:crop_damage_assessment_app/components/decoration.dart';

class ViewClaim extends StatefulWidget {
  const ViewClaim({Key? key, required this.uid}) : super(key: key);

  final String? uid;

  @override
  _AddClaimState createState() => _AddClaimState();
}

class _AddClaimState extends State<ViewClaim> {
  final AuthService _auth = AuthService();

  String error = "";
  bool loading = false;
  bool isSubmit = false;
  bool isSubmitComplete = false;

  // text field state
  String claim_name = "";
  String crop_type = "";
  String reason = "";
  String description = "";
  String agrarian_division = "";
  String province = "";

  String damage_area = "";
  String estimate = "";

  String damage_date = DateFormat("yyyy-MM-dd").format(DateTime.now());

  XFile? video_file;
  List<XFile>? image_files = <XFile>[];

  late VideoPlayerController _videoPlayerController;

  set _imageFile(XFile? value) {
    if (value != null) {
      if (image_files != null) {
        image_files?.addAll(<XFile>[value]);
      }
    }
  }

  final picker = ImagePicker();

  Future getImage() async {
    try {
      var pickedFile = await picker.pickImage(source: ImageSource.camera);

      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  Future getVideo() async {
    try {
      var pickedFile = await picker.pickVideo(source: ImageSource.camera);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        setState(() {
          video_file = pickedFile;
        });
        // video_file = XFile(pickedFile.path);
        _videoPlayerController =
            VideoPlayerController.file(File(pickedFile.path))
              ..initialize().then((_) => {setState(() {})});

        _videoPlayerController.play();

        print("Video is selected.");
      } else {
        print("No video is selected.");
      }
    } catch (e) {
      print("error while picking video - " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final claims = Provider.of<List<Claim?>>(context);

    print("claims - ");
    for (var claim in claims) {
      print(claim!.claim_name);
    }
    print("claims end");

    return loading
        ? const Loading()
        : SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Container());
  }
}
