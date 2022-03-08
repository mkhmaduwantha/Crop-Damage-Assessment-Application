import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_damage_assessment_app/models/user.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference user_collection = FirebaseFirestore.instance.collection('user');

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
    return await user_collection.doc(uid).set(user_data, SetOptions(merge: true));
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
}
