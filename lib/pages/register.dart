import 'package:firebase_app/auth_validator.dart';
import 'package:firebase_app/helper/helper_function.dart';
import 'package:firebase_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  //Global key to connect buttons
  final _key = GlobalKey<FormState>();

  late AuthValidators authValidators;
  late AuthService authService;

  late TextEditingController usrNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPassController;
  late TextEditingController fullNameController;
  // late TextEditingController langController;

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode usrNameFocusNode;
  late FocusNode confirmPassFocusNode;
  late FocusNode fullNameFocusNode;
  // late FocusNode langFocusNode;

  bool obscureText = true;
  late Timer _timer;

  bool _isLoading = false;
  //AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();

    authValidators = AuthValidators();
    authService = AuthService();

    usrNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPassController = TextEditingController();
    fullNameController = TextEditingController();
    // langController = TextEditingController();

    passwordController.addListener(toggleObscureText);

    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    usrNameFocusNode = FocusNode();
    confirmPassFocusNode = FocusNode();
    fullNameFocusNode = FocusNode();
    // langFocusNode = FocusNode();

    _timer = Timer(const Duration(seconds: 3), () {});
  }

  String fullName = "";
  String userName = "";
  String email = "";
  String password = "";
  // String lang = "";

  @override
  void dispose() {
    super.dispose();

    _timer.cancel();

    emailController.dispose();
    passwordController.dispose();
    usrNameController.dispose();
    confirmPassController.dispose();
    fullNameController.dispose();
    // langController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    usrNameFocusNode.dispose();
    confirmPassFocusNode.dispose();
    fullNameFocusNode.dispose();
    // langFocusNode.dispose();
  }

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
      _resetTimer();
    });
  }

  void _resetTimer() {
    _timer.cancel();
    _timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        obscureText = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    fullName = fullNameController.text;
    userName = usrNameController.text;
    email = emailController.text;
    password = passwordController.text;
    // lang = langController.text;

    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/wolfnight.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor))
            : Stack(
                children: [
                  SingleChildScrollView(
                      child: Container(
                          height: size.height,
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.1,
                              left: 40,
                              right: 40),
                          child: Form(
                              key: _key,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello there',
                                    style: TextStyle(
                                      fontSize: 40,
                                      foreground: Paint()
                                        ..color = const Color.fromRGBO(
                                            219, 126, 193, 0.612),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.05),
                                  DynamicInputWidget(
                                      controller: fullNameController,
                                      obscureText: false,
                                      currentFocusNode: fullNameFocusNode,
                                      toggleObscureText: toggleObscureText,
                                      validator: authValidators.check,
                                      hintText: 'Full Name',
                                      textInputAction: TextInputAction.next,
                                      isNonPasswordField: true),
                                  SizedBox(height: size.height * 0.025),
                                  DynamicInputWidget(
                                      controller: usrNameController,
                                      obscureText: false,
                                      currentFocusNode: usrNameFocusNode,
                                      toggleObscureText: toggleObscureText,
                                      validator: authValidators.check,
                                      hintText: 'User Name',
                                      textInputAction: TextInputAction.next,
                                      isNonPasswordField: true),
                                  SizedBox(height: size.height * 0.025),
                                  DynamicInputWidget(
                                      controller: emailController,
                                      obscureText: false,
                                      currentFocusNode: emailFocusNode,
                                      toggleObscureText: toggleObscureText,
                                      validator: authValidators.emailValidator,
                                      hintText: 'Email',
                                      textInputAction: TextInputAction.next,
                                      isNonPasswordField: true),
                                  SizedBox(height: size.height * 0.025),
                                  DynamicInputWidget(
                                      controller: passwordController,
                                      currentFocusNode: passwordFocusNode,
                                      obscureText: obscureText,
                                      toggleObscureText: toggleObscureText,
                                      validator:
                                          authValidators.passwordVlidator,
                                      hintText: 'Password',
                                      textInputAction: TextInputAction.next,
                                      isNonPasswordField: false),
                                  SizedBox(height: size.height * 0.025),
                                  DynamicInputWidget(
                                    controller: confirmPassController,
                                    obscureText: true,
                                    currentFocusNode: confirmPassFocusNode,
                                    toggleObscureText: toggleObscureText,
                                    validator:
                                        authValidators.confirmPasswordValidator,
                                    hintText: 'confirm Password',
                                    isNonPasswordField: true,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(height: size.height * 0.07),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          register();
                                          // if (_key.currentState!.validate()) {
                                          //   Navigator.popAndPushNamed(
                                          //       context, 'home');
                                          // }
                                          // {
                                          //   DynamicInputWidget.msgPopUp(
                                          //       _key.currentState);
                                          // }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shadowColor: Colors.white,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 185, 0, 182),
                                            foregroundColor:
                                                const Color.fromARGB(
                                                    255, 233, 227, 227),
                                            disabledBackgroundColor:
                                                const Color.fromARGB(
                                                    254, 255, 254, 254),
                                            elevation: 2.0,
                                            padding: const EdgeInsets.fromLTRB(
                                                30, 10, 30, 10),
                                            textStyle: const TextStyle(
                                              fontSize: 20,
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(45))),
                                        child: const Text(
                                          'Sign Up',
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.04),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Container(
                                          height: 1.0,
                                          width: 130.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Text(
                                        'OR',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Container(
                                          height: 1.0,
                                          width: 130.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.015),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          color: Colors.red,
                                          padding: const EdgeInsets.all(4),
                                          onPressed: () {},
                                          icon: Image.asset(
                                            'assets/images/twitter.png',
                                            color: Colors.blue,
                                          )),
                                      IconButton.filled(
                                          padding: const EdgeInsets.all(4),
                                          onPressed: () {},
                                          icon: Image.asset(
                                            'assets/images/apple.png',
                                            color: Colors.white,
                                          )),
                                      IconButton.filled(
                                          padding: const EdgeInsets.all(4),
                                          onPressed: () {},
                                          icon: Image.asset(
                                            'assets/images/google.png',
                                          )),
                                    ],
                                  )
                                ],
                              )))),
                  Positioned(
                      top: size.height - 40,
                      left: size.width * 0.5 - 150,
                      child: Row(
                        children: [
                          const Text(
                            "Already have an account ? ",
                            style: TextStyle(
                                color: Colors.white30,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(context, 'login');
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Color.fromARGB(156, 219, 126, 193),
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                            ),
                          )
                        ],
                      ))
                ],
              ),
      ),
    );
  }

  register() async {
    if (_key.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password, userName)
          .then((value) async {
        if (value == true) {
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(userName);
          await HelperFunctions.saveUserPassSF(password);
          Navigator.popAndPushNamed(context, 'home');
          // Navigator.of(context).pushNamed('home');
          // await Future.delayed(const Duration(seconds: 2));
          // if (context.mounted) Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: const Color.fromARGB(205, 219, 30, 30),
            content: Text(
              value.toString(),
              textAlign: TextAlign.center,
            ),
            duration: const Duration(seconds: 4),
          ));
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}

class DynamicInputWidget extends StatelessWidget {
  const DynamicInputWidget(
      {required this.controller,
      required this.obscureText,
      required this.currentFocusNode,
      required this.validator,
      required this.hintText,
      required this.isNonPasswordField,
      required this.textInputAction,
      required this.toggleObscureText,
      Icon? prefIcon,
      Key? key})
      : super(key: key);

  final bool isNonPasswordField;
  final TextEditingController controller;
  final VoidCallback? toggleObscureText;
  final bool obscureText;
  final FocusNode currentFocusNode;
  final String? Function(String?)? validator;
  final Icon? prefIcon = null;
  final String hintText;
  final TextInputAction? textInputAction;

  // Create a scaffold messanger
  static SnackBar msgPopUp(msg) {
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
      textInputAction: textInputAction,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(166, 244, 237, 237),
          ),
          prefixIcon: prefIcon,
          suffixIcon: isNonPasswordField
              ? null
              : IconButton(
                  onPressed: toggleObscureText,
                  icon: obscureText
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: const TextStyle(fontSize: 12)),
      onChanged: (value) {
        if (isNonPasswordField == false) {
          AuthValidators.firstPass = value;
        }
      },
      focusNode: currentFocusNode,
      obscureText: obscureText,
      validator: validator,
      onTapOutside: (event) {
        currentFocusNode.unfocus();
      },
      onEditingComplete: () {
        if (isNonPasswordField == false) {
          AuthValidators.firstPass = controller.text;
        }
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
