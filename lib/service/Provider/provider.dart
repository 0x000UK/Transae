import 'package:firebase_app/Models/user_model.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userModelProviderFuture = FutureProvider<UserModel?>((ref) async {
  UserModel? userModel;
  User? currentUser = FirebaseAuth.instance.currentUser;
  if(currentUser != null) {
      DatabaseService.current_uid = currentUser.uid;
      userModel = await DatabaseService.getUserDataByID(null);
  }
  else {
    userModel = null;
  }
  return userModel;
});

final userModelProviderState = StateProvider((ref) {

  final userModel = ref.watch(userModelProviderFuture).asData?.value;
  return userModel;

});

final themeProviderState = StateProvider((ref) {

 ThemeMode currentMode = ThemeMode.system;
 return currentMode;

});

final friendRequestProvider = StateProvider((ref) {

  final List<UserModel> sent = [];
  return sent;
  
});