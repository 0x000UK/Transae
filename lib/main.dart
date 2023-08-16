import 'package:firebase_app/Models/UserModel.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:firebase_app/service/FireBase/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/auth/login.dart';
import 'pages/home.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  User? currentUser = FirebaseAuth.instance.currentUser;
  if(currentUser != null) {

    UserModel? userModel = await DatabaseService.getUserDataByID(currentUser.uid);
    if(userModel != null) {
      runApp(Home(userModel: userModel));
    }
    else {
    runApp(const Login());
    }
  }
  else {
    runApp(const Login());
  }
}

class Login extends StatelessWidget {

  const Login({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context ){

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyLogin(),
    );
  }
}

class Home extends StatelessWidget {

  final UserModel userModel;

  const Home({super.key, required this.userModel});

  @override
  Widget build(BuildContext context ){

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(userModel: userModel),
    );
  }
}