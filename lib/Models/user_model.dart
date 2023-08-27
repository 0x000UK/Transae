class UserModel {
  String? uid;
  String? userName;
  String? fullName;
  String? email;
  String? profilePic;

  UserModel({this.uid, this.fullName,this.userName, this.email, this.profilePic});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullName = map["fullName"];
    userName = map["userName"];
    email = map["email"];
    profilePic = map["profilePic"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullName,
      "username" : userName,
      "email": email,
      "profilepic": profilePic,
    };
  }
}