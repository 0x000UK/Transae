import 'package:firebase_app/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth_validator.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  //Global key to connect buttons
  final _key = GlobalKey<FormState>();

  //initiate Auth validator
  late AuthValidators authValidators;
  late AuthService authService;
  // controllers
  late TextEditingController emailController;
  late TextEditingController passwordController;

  // create focus nodes
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  // to obscure text default value is false
  bool obscureText = true;

  String email = "";
  String password = "";
  bool _isLoading = false;

  // Instantiate all the *text editing controllers* and focus nodes on *initState* function
  @override
  void initState() {
    super.initState();

    authValidators = AuthValidators();
    authService = AuthService();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  // Create a function that'll toggle the password's visibility on the relevant icon tap.
  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    email = emailController.text;
    password = passwordController.text;
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/sunset.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              )
            : Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: size.height * 0.25, left: size.width * 0.5 - 130),
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(
                          //color: Color.fromARGB(113, 255, 255, 255),
                          fontSize: 40,
                          foreground: Paint()
                            ..blendMode = BlendMode.xor
                            ..color = const Color.fromARGB(112, 11, 7, 7)),
                    ),
                  ),
                  SingleChildScrollView(
                      child: Container(
                          height: size.height,
                          padding: EdgeInsets.only(
                              top: size.height * 0.5,
                              left: 40,
                              right: 40,
                              bottom: 0),
                          child: Form(
                              key: _key,
                              child: Column(
                                children: [
                                  DynamicInputWidget(
                                    controller: emailController,
                                    obscureText: false,
                                    currentFocusNode: emailFocusNode,
                                    toggleObscureText: toggleObscureText,
                                    validator: authValidators.emailValidator,
                                    prefIcon: const Icon(Icons.person),
                                    labelText: 'Email',
                                    isNonPasswordField: true,
                                  ),
                                  const SizedBox(height: 30),
                                  DynamicInputWidget(
                                    controller: passwordController,
                                    obscureText: obscureText,
                                    currentFocusNode: passwordFocusNode,
                                    toggleObscureText: toggleObscureText,
                                    validator: authValidators.passwordVlidator,
                                    prefIcon: const Icon(Icons.lock),
                                    labelText: 'Password',
                                    isNonPasswordField: false,
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          login();
                                          // if (_key.currentState!.validate()) {
                                          //   Navigator.popAndPushNamed(
                                          //       context, 'home');
                                          // }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    231, 44, 0, 121),
                                            foregroundColor: Colors.white54,
                                            disabledBackgroundColor:
                                                Colors.black12,
                                            elevation: 2.0,
                                            padding: const EdgeInsets.fromLTRB(
                                                60, 10, 60, 10),
                                            textStyle: const TextStyle(
                                              fontSize: 20,
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(45))),
                                        child: const Text(
                                          'Sign In',
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )))),
                  Positioned(
                      top: size.height - 100,
                      left: size.width * 0.5 - 130,
                      child: Column(children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 15, 17, 26),
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account ? ",
                              style: TextStyle(
                                  color: Colors.white30,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(context, 'register');
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 28, 52, 189),
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                            )
                          ],
                        )
                      ]))
                ],
              ),
      ),
    );
  }

  // login() async {
  //   if (_key.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     await authService
  //         .loginWithUserNameandPassword(email, password)
  //         .then((value) async {
  //       if (value == true) {
  //         QuerySnapshot snapshot =
  //             await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
  //                 .gettingUserData(email);
  //         // saving the values to our shared preferences
  //         await HelperFunctions.saveUserLoggedInStatus(true);
  //         // await HelperFunctions.saveUserEmailSF(email);
  //         // await HelperFunctions.saveUserNameSF(snapshot.docs[2]['userName']);

  //         Navigator.popAndPushNamed(context, 'home');
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           backgroundColor: const Color.fromARGB(205, 219, 30, 30),
  //           content: Text(
  //             value.toString(),
  //             textAlign: TextAlign.center,
  //           ),
  //           duration: const Duration(seconds: 4),
  //         ));
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       }
  //     });
  //   }
  // }
  Future<void> login() async {
    if (_key.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final UserCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.popAndPushNamed(context, 'home');
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(205, 219, 30, 30),
          content: Text(
            e.code.toString(),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 4),
        ));
        setState(() {
          _isLoading = false;
        });
      }
      // print("LOMGIN FAIMLED: $e");
    }
  }
}

class DynamicInputWidget extends StatelessWidget {
  const DynamicInputWidget(
      {required this.controller,
      required this.obscureText,
      required this.currentFocusNode,
      required this.toggleObscureText,
      required this.validator,
      required this.prefIcon,
      required this.labelText,
      required this.isNonPasswordField,
      Key? key})
      : super(key: key);

  final bool isNonPasswordField;
  final TextEditingController controller;
  final VoidCallback? toggleObscureText;
  final bool obscureText;
  final FocusNode currentFocusNode;
  final String? Function(String?)? validator;
  final Icon prefIcon;
  final String labelText;

  // Create a scaffold messanger
  SnackBar msgPopUp(msg) {
    return SnackBar(
      content: Text(
        msg.toString(),
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enableSuggestions: isNonPasswordField,
      autocorrect: isNonPasswordField,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(45.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: const BorderSide(color: Colors.black),
        ),
        label: Text(labelText),
        prefixIcon: prefIcon,
        suffixIcon: isNonPasswordField
            ? null
            : IconButton(
                onPressed: toggleObscureText,
                icon: obscureText
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
        //floatingLabelBehavior: FloatingLabelBehavior.auto,
        errorStyle: const TextStyle(fontSize: 0),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
      focusNode: currentFocusNode,
      obscureText: obscureText,
      validator: validator,
      onTapOutside: (event) {
        currentFocusNode.unfocus();
      },
      onEditingComplete: () {
        if (validator!(controller.text) != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(msgPopUp(validator!(controller.text)));
        } else {
          FocusScope.of(context).nextFocus();
        }
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Auth Form',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: AuthForm(),
//     );
//   }
// }

// class AuthForm extends StatefulWidget {
//   @override
//   _AuthFormState createState() => _AuthFormState();
// }

// class _AuthFormState extends State<AuthForm> {
//   final AuthValidators authValidators = AuthValidators();
//   final _formKey = GlobalKey<FormState>();
//   //final _formKey1 = GlobalKey<FormFieldState>();
//   //List <GlobalKey<FormFieldState>> form = [];
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   late FocusNode _focusNode;
//   late FocusNode _focusNode1;

//   void initState() {
//     super.initState();

//     _emailController = TextEditingController();
//     _passwordController = TextEditingController();
//     //form[0] = GlobalKey<FormFieldState>();
//     //form[1] = GlobalKey<FormFieldState>();
//     _focusNode = FocusNode();
//     _focusNode1 = FocusNode();
//   }

//   void dispose() {
//     super.dispose();

//     _emailController.dispose();
//     _passwordController.dispose();
//     _focusNode.dispose();
//     _focusNode1.dispose();
//   }

//   SnackBar msgPopUp(msg) {
    
//     return SnackBar(
//       content: Text(
//         msg,
//         textAlign: TextAlign.center,
//       ),
//       backgroundColor: Colors.black45,
      
//       duration: Duration(seconds: 4),
//     );
//   }
//   // void _requestFocus() {
//   //   setState(() {
//   //     FocusScope.of(context).requestFocus(_focusNode);
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Auth Form'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 focusNode: _focusNode,
//                 controller: _emailController,
//                 textInputAction: TextInputAction.next,
//                 onTapOutside: (event) {
//                      _focusNode.unfocus();
//                      //FocusScope.of(context).requestFocus(null);
//                 },
                
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   errorStyle: TextStyle(
//                     fontSize:0
//                   )
//                 ),
//                 validator: authValidators.emialValidator,
//                 onEditingComplete: () {
//                   if (authValidators.emialValidator(_emailController.text) != null) {
//                     ScaffoldMessenger.of(context).showSnackBar(msgPopUp(AuthValidators.emailErrMsg));
//                   }
//                   else {
//                     FocusScope.of(context).nextFocus();
//                   }
//                 },
//               ),
//               TextFormField(
//                 focusNode: _focusNode1,
//                 controller: _passwordController,
//                 textInputAction: TextInputAction.done,
                
//                 onTapOutside: (event) {
//                      _focusNode1.unfocus();
//                      //FocusScope.of(context).requestFocus(null);
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   //focusedBorder: OutlineInputBorder()
//                 ),
//                 obscureText: true,
//                 //4onTap: ,
//                 validator: authValidators.passwordVlidator,
//                 onEditingComplete: () {
//                   if (authValidators.passwordVlidator(_passwordController.text) != null) {
//                     ScaffoldMessenger.of(context).showSnackBar(msgPopUp(AuthValidators.passwordErrMsg));
//                   }
//                   else {
//                     _focusNode1.unfocus();
//                   }
//                 },
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed:(){},
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }