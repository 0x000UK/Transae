import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Models/UserModel.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for our collections
  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  static final CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection("chatrooms");

  // saving the userdata
  Future savingUserData(
      String fullName, String email, String password) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "userName": "" ,
      "profilePic": "",
      "uid": uid,
      "password": password,
    });
  }

  // getting user data by email
  static Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
  // get User data by uid
  static Future<UserModel?> getUserDataByID( String uid) async {
    UserModel? userModel;
    DocumentSnapshot docSnap = await userCollection.doc(uid).get();

    if(docSnap.data() != null){
      userModel = UserModel.fromMap(docSnap.data() as Map<String,dynamic>);
    }
    return userModel;
  }


  Future savingChatData( String text, String translatedTxt, String senderId) async {
    return await chatsCollection.doc(uid).set({
      "text": text,
      "translatedTex": translatedTxt,
      "initialLanguage": "",
      "finalLanguage": "",
      "sender" : senderId,
      "timeStamp" : FieldValue.serverTimestamp(),
    });
  }
  sendMessage( Map<String, dynamic> chatMessageData) async {
    chatsCollection.add(chatMessageData);
  }

}
