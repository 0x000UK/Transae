class UserModel {
  String? uid;
  String? userName;
  String? fullName;
  String? email;
  String? profilePic;
  String? password;
  Map<String, dynamic>? freinds;
  String? background;

  UserModel({this.uid, this.fullName,this.userName,this .freinds, this.email, this.profilePic, this.background, this.password});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullName = map["fullName"];
    userName = map["userName"];
    email = map["email"];
    freinds = map["freinds"];
    profilePic = map["profilePic"];
    password = map["password"];
    background = map["background"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullName": fullName,
      "userName" : userName,
      "email": email,
      "freinds": freinds,
      "profilePic": profilePic,
      "password": password,
      "background": profilePic,
    };
  }
}