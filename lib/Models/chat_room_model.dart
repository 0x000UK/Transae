class ChatRoomModel {
  String? chatroomid;
  Map<String, dynamic>? members;
  String? lastMessage;

  ChatRoomModel({this.chatroomid, this.members, this.lastMessage});

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatroomid = map["chatroomid"];
    members = map["members"];
    lastMessage = map["lastmessage"];
  }

  Map<String, dynamic> toMap() {
    return {
      "chatroomid": chatroomid,
      "members": members,
      "lastmessage": lastMessage
    };
  }
}