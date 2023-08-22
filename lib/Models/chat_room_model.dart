class ChatRoomModel {
  String? chatroomid;
  Map<String, dynamic>? members;
  String? lastMessage;
  String? sender;

  ChatRoomModel({this.chatroomid, this.members, this.lastMessage, this.sender});

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatroomid = map["chatroomid"];
    members = map["members"];
    lastMessage = map["lastmessage"];
    sender = map["sender"];
  }

  Map<String, dynamic> toMap() {
    return {
      "chatroomid": chatroomid,
      "members": members,
      "lastmessage": lastMessage,
      "sender": sender
    };
  }
}