import 'package:firebase_app/service/FireBase/helper_function.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      return user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // register
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      await DatabaseService(uid: user.uid)
          .savingUserData(fullName, email, password);

      return user;
    } on FirebaseAuthException catch (e) {
      // print(e);
      return e.message;
    }
  }

  // signout
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await HelperFunctions.saveUserLangSF("");
      await HelperFunctions.saveUserPassSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
