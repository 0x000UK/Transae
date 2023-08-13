import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  // saving the userdata
  Future savingUserData(
      String fullName, String email, String userName, String password) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "userName": userName,
      "groups": [],
      "profilePic": "",
      "uid": uid,
      "friends": [],
      "password": password,
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
