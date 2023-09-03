import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Models/user_model.dart';
import 'package:firebase_app/Widgets/warnings.dart';
import 'package:firebase_app/pages/auth/register.dart';
import 'package:firebase_app/service/FireBase/auth_service.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/auth_validator.dart';
import 'package:firebase_app/pages/navigation.dart';
import 'package:firebase_app/service/Provider/provider.dart';


class MyLogin extends ConsumerStatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  ConsumerState<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends ConsumerState<MyLogin> {
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

  UserModel? userModel;

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
                    padding: EdgeInsets.only(top: size.height * 0.25, left: size.width * 0.5 - 130),
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
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyRegister()));
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
                      ]
                    )
                  )
                ],
              ),
      ),
    );
  }
  
  Future<void> login() async {
    if (_key.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      UserCredential? userCredential;
      try {
          userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
            //await HelperFunctions.saveUserEmailSF(email);
            //await HelperFunctions.saveUserPassSF(password);
      } on FirebaseAuthException catch (e) {
        showWarning(context, e.code.toString());
        setState(() {
          _isLoading = false;
        });
      }

      if(userCredential != null) {
        String uid = userCredential.user!.uid;
        DatabaseService.current_uid = uid;
        DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        userModel = UserModel.fromMap(userData.data() as Map<String,dynamic>);
        ref.read(userModelProviderState.notifier).state = userModel;
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage(userModel: userModel!)));
      }
      else {
        showWarning(context, "UserData is null");
      }
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
      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(45.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: const BorderSide(color: Colors.black),
        ),
        label: Text(labelText, style: Theme.of(context).textTheme.titleSmall ),
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