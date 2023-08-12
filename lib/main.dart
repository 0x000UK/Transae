import 'package:firebase_app/firebase_options.dart';
import 'package:firebase_app/helper/helper_function.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // #me start

  bool _isSignedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus() async {
      await HelperFunctions.getUserLoggedInStatus().then((value) {
        if (value != null) {
          setState(() {
            _isSignedIn = value;
          });
        }
      });
    }
  }
  // #meBlock Over

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: _isSignedIn ? 'home' : 'login',
      routes: {
        'login': (context) => const MyLogin(),
        'register': (context) => const MyRegister(),
        'home': (context) => const MyHomePage(),
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: 'login',
//       routes: {
//         'login': (context) => const MyLogin(),
//         'register': (context) => const MyRegister(),
//         'home': (context) => const MyHomePage(),
//       },
//     );
//   }
// }
