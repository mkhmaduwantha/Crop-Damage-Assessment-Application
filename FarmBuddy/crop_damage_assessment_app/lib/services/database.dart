import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:crop_damage_assessment_app/models/user.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference user_collection =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference claim_collection =
      FirebaseFirestore.instance.collection('claim');

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
}
