import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Models/UserModel.dart';
import 'package:firebase_app/Models/chat_room_model.dart';
import 'package:firebase_app/Models/message_model.dart';
import 'package:firebase_app/main.dart';
class DatabaseService {
  static String? uid;

  // reference for our collections
  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  static final CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection("chatrooms");

  // saving the userdata
  static Future savingUserData( String fullName, String email, String password) async {
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
  static Future getUserDataByEmail(String email ) async {
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

  static Future<ChatRoomModel?> getChatRoomModel (UserModel targetUser) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await chatsCollection.
    where("members.$uid", isEqualTo: true).
    where("members.${targetUser.uid}", isEqualTo: true).get();

    if(snapshot.docs.isNotEmpty) {
      // Fetch the existing one
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom = ChatRoomModel.fromMap(docData as Map<String, dynamic>);

      chatRoom = existingChatroom;
    }
    else {
      // Create a new one
      ChatRoomModel newChatroom = ChatRoomModel(
        chatroomid: uuid.v1(),
        lastMessage: "",
        sender: "",
        members: {
          uid.toString(): true,
          targetUser.uid.toString(): false,
        },
      );
      await chatsCollection.doc(newChatroom.chatroomid).set(newChatroom.toMap());

      chatRoom = newChatroom;
    }
    return chatRoom;
  }

  static dynamic getChatRooms() {
     dynamic snapshot = chatsCollection.where('members.$uid', isEqualTo: true).snapshots();
    return snapshot;
  }

  static dynamic getchats(String chatRoomId) {
    dynamic snapshot = chatsCollection.doc(chatRoomId).collection('messages').orderBy("timeSent", descending: true).snapshots();
    return snapshot;
  }

  static savingChatData(String chatRoomId, String messageID , MessageModel message) async {
    return chatsCollection
    .doc(chatRoomId)
    .collection("messages")
    .doc(messageID)
    .set( message.toMap());
  }
}
