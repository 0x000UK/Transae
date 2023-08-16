class UserModel {
  String? uid;
  String? userName;
  String? fullname;
  String? email;
  String? profilepic;

  UserModel({this.uid, this.fullname,this.userName, this.email, this.profilepic});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    userName = map["userName"];
    email = map["email"];
    profilepic = map["profilepic"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "username" : userName,
      "email": email,
      "profilepic": profilepic,
    };
  }
}