import 'dart:io';
import 'package:crop_damage_assessment_app/models/farmer.dart';
import 'package:path/path.dart';
import 'package:latlng/latlng.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_damage_assessment_app/models/claim.dart';
import 'package:crop_damage_assessment_app/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DatabaseService {
  final String? uid;
  late String? select_uid;
  // String? select_claim_state;
  // String? select_agrarian_division;

  DatabaseService({required this.uid});

  set set_select_uid(String select_uid) {
    this.select_uid = select_uid;
  }

  // set set_select_claim_state(String select_claim_state) {
  //   this.select_claim_state = select_claim_state;
  // }

  // set set_select_agrarian_division(String select_agrarian_division) {
  //   this.select_agrarian_division = select_agrarian_division;
  // }

  // collection reference
  final CollectionReference user_collection = FirebaseFirestore.instance.collection('user');
  final CollectionReference claim_collection = FirebaseFirestore.instance.collection('claim');

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return UserData(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      type: data['type'],
    );
  }

  // claim data from snapshots
  List<Claim?> _claimDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {

      return Claim(
          uid: doc['uid'],
          status: doc['status'] ?? "Pending",
          timestamp: doc['timestamp'] ?? 0,
          claim_name: doc['claim_name'] ?? "",
          crop_type: doc['crop_type'] ?? "",
          reason: doc['reason'] ?? "",
          description: doc['description'] ?? "",
          agrarian_division: doc['agrarian_division'] ?? "",
          province: doc['province'] ?? "",
          damage_date: doc['damage_date'] ?? "",
          damage_area: doc['damage_area'] ?? "",
          estimate: doc['estimate'] ?? "",
          claim_image_urls: doc['claim_image_urls'] ?? [],
          claim_video_url: doc['claim_video_url'] ?? "",
          claim_location: LatLng(doc['claim_location'].latitude, doc['claim_location'].longitude));
    }).toList();
  }

  // get user doc stream
  Stream<UserData> get userData {
    print("search user");
    return user_collection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future updateUserData(var user_data) async {
    bool isSuccess = false;
    await user_collection
        .doc(uid)
        .set(user_data, SetOptions(merge: true))
        .then((value) {
      print("User Added/Updated");
      isSuccess = true;
    })
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => print("Failed to add user: $error"));
    return isSuccess;
  }

  Future<Farmer?> getUserData(String? select_uid) async {
    Farmer? user;
    await user_collection
        .doc(select_uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        user = Farmer(
            uid: data['uid'] ?? "",
            phone_no: data['phone_no'] ?? "",
            name: data['name'] ?? "",
            email: data['email'] ?? "",
            type: data['type'] ?? "",
            agrarian_division: data['agrarian_division'] ?? "",
            nic: data['nic'] ?? "",
            address: data['address'] ?? "",
            province: data['province'] ?? "",
            bank: data['bank'] ?? "",
            account_name: data['account_name'] ?? "",
            account_no: data['account_no'] ?? "",
            branch: data['branch'] ?? "",
            profile_url: data['profile_url'] ?? "");
      } else {
        print('User does not exist on the database');
      }
    });

    return user;
  }

  Future addClaimData(var claim_data) async {
    bool isSuccess = false;
    await claim_collection.add(claim_data).then((value) {
      print("Claim Added");
      print(claim_data);
      isSuccess = true;
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => print("Failed to claim data - " + error));
    return isSuccess;
  }

  Future uploadFileToFirebase( String root, String referName, XFile? imageFile) async {
    String downloadURL = "";
    String fileName = referName + DateTime.now().millisecondsSinceEpoch.toString() + extension(imageFile!.path);
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
    print("select_uid - " + select_uid!);
    return claim_collection
        .orderBy('timestamp', descending: true)
        .where('uid', isEqualTo: select_uid)
        .snapshots()
        .map(_claimDataFromSnapshot);
  }

  Stream<List<Claim?>> officerClaimList(String? select_claim_state, String? select_agrarian_division) {
    print("select claim_state - " + select_claim_state!);
    print("select agrarian_division - " + select_agrarian_division!);
    return claim_collection
        .orderBy('timestamp', descending: true)
        .where('status', isEqualTo: select_claim_state)
        .where('agrarian_division', isEqualTo: select_agrarian_division)
        .snapshots()
        .map(_claimDataFromSnapshot);
  }
}
