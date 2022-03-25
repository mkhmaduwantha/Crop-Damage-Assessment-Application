import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_damage_assessment_app/models/claim.dart';
import 'package:crop_damage_assessment_app/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DatabaseService {
  final String? uid;

  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference user_collection = FirebaseFirestore.instance.collection('user');
  final CollectionReference claim_collection = FirebaseFirestore.instance.collection('claim');

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return UserData(
      uid: uid,
      name: data['name'],
      email: data['email'],
      type: data['type'],
    );
  }

  // claim data from snapshots
  List<Claim?> _claimDataFromSnapshot(QuerySnapshot snapshot) {

    return snapshot.docs.map((doc){
      //print(doc.data);
      return Claim(
        uid: doc['uid'],
        timestamp: doc['uid'] ?? 0,
        claim_name: doc['claim_name'] ?? "",
        crop_type: doc['crop_type'] ?? "",
        reason: doc['reason'] ?? "",
        description: doc['description'] ?? "",
        agrarian_division: doc['agrarian_division'] ?? "",
        province: doc['province'] ?? "",
        damage_date: doc['damage_date'] ?? "",
        damage_area: doc['damage_area'] ?? "",
        estimate: doc['estimate'] ?? "",
        claim_image_urls: doc['claim_image_urls'] ?? "",
        claim_video_url: doc['claim_video_url'] ?? ""
      );
    }).toList();

  }

  // get user doc stream
  Stream<UserData> get userData {
    print("search user");
    return user_collection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future updateUserData(var user_data) async {
    return await user_collection
        .doc(uid)
        .set(user_data, SetOptions(merge: true));
  }

  Future getUserData() async {
    await user_collection
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  Future addClaimData(var claim_data) async {
    bool isSuccess = false;
    await claim_collection.add(claim_data).then((value) {
      print("Claim Added");
      isSuccess = true;
    // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => print("Failed to claim data - " + error));
    return isSuccess;
  }

  Future uploadFileToFirebase(
      String root, String referName, XFile? imageFile) async {
    String downloadURL = "";
    String fileName = referName +
        DateTime.now().millisecondsSinceEpoch.toString() +
        extension(imageFile!.path);
    String refer = '$root/$uid/$fileName';
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(refer)
          .putFile(File(imageFile.path));
      downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref(refer)
          .getDownloadURL();
      return downloadURL;
    } catch (error) {
      print(error.toString());
      return downloadURL;
    }
  }

  Stream<List<Claim?>> get farmerClaimList {
    return claim_collection.snapshots().map(_claimDataFromSnapshot);
  }
}
