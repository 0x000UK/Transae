import 'package:firebase_app/Widgets/warnings.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/pages/auth/login.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user!;

      return user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // register
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {

      User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user!;
      await DatabaseService.savingUserData(fullName, email, password);
      return user;

    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // signout
  Future signOut(BuildContext context) async {
    // try {
    //   await HelperFunctions.saveUserLoggedInStatus(false);
    //   await HelperFunctions.saveUserEmailSF("");
    //   await HelperFunctions.saveUserNameSF("");
    //   await HelperFunctions.saveUserLangSF("");
    //   await HelperFunctions.saveUserPassSF("");
    //   await firebaseAuth.signOut();
    // } catch (e) {
    //   return null;
    // }
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MyLogin()));
    } catch (error) {
      showWarning(context, error);
    }
  }
}
