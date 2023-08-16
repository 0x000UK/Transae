class MessageModel {
  String? messageid;
  String? sender;
  String? text;
  bool? seen;
  DateTime? time;

  MessageModel({this.messageid, this.sender, this.text, this.seen, this.time});

  MessageModel.fromMap(Map<String, dynamic> map) {
    messageid = map["messageid"];
    sender = map["sender"];
    text = map["text"];
    seen = map["seen"];
    time = map["time"].toDate();    
  }

  Map<String, dynamic> toMap() {
    return {
      "messageid": messageid,
      "sender": sender,
      "text": text,
      "seen": seen,
      "time": time
    };
  }
}