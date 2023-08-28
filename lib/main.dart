import 'package:firebase_app/Models/user_model.dart';
import 'package:firebase_app/Widgets/colors.dart';
import 'package:firebase_app/Widgets/themes.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:firebase_app/service/FireBase/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'pages/auth/login.dart';
import 'pages/navigation.dart';

Uuid uuid = const Uuid();


void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );

    User? currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null) {
      DatabaseService.current_uid = currentUser.uid;
      UserModel? userModel = await DatabaseService.getUserDataByID(null);
      if(userModel != null) {
        runApp(ProviderScope(child: Home(userModel: userModel)));
      }
      else {
      runApp( const Login());
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

    return   ProviderScope(
    child : MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme(),
      darkTheme: Themes.darkTheme(),
      //themeMode: ThemeMode.light,
      home: const MyLogin(),
    )
    );
  }
}

class Home extends StatelessWidget {

  final UserModel userModel;

  const Home({super.key, required this.userModel});

  @override
  Widget build(BuildContext context ){

    return ProviderScope(
      child : MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.lightTheme(),
        darkTheme: Themes.darkTheme(),
        home: MyHomePage(userModel: userModel),
    ));
  }
}