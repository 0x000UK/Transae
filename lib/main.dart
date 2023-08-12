import 'package:flutter/material.dart';
import 'pages/auth/login.dart';
import 'pages/auth/register.dart';
import 'pages/home.dart';



void main() {
  runApp(const  MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login' :(context) => const MyLogin(),
        'register' :(context) => const MyRegister(),
        'home' : (context) => const MyHomePage(),
      },
    );
  }
}