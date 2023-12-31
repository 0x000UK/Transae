import 'package:firebase_app/Widgets/warnings.dart';
import 'package:firebase_app/pages/auth/login.dart';
import 'package:firebase_app/pages/navigation.dart';
import 'package:firebase_app/service/auth_validator.dart';
import 'package:firebase_app/service/FireBase/auth_service.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_app/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/service/Provider/provider.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyRegister extends ConsumerStatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  ConsumerState<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends ConsumerState<MyRegister> {
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
                  physics:const ClampingScrollPhysics(),
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
                                  fontSize: 30,
                                  foreground: Paint()
                                    ..color = const Color.fromRGBO(
                                        219, 126, 193, 0.612),
                                ),
                              ),
                              SizedBox(height: size.height * 0.1),
                              DynamicInputWidget(
                                  controller: fullNameController,
                                  obscureText: false,
                                  currentFocusNode: fullNameFocusNode,
                                  toggleObscureText: toggleObscureText,
                                  validator: authValidators.check,
                                  hintText: 'Full Name',
                                  textInputAction: TextInputAction.next,
                                  isNonPasswordField: true),
                              SizedBox(height: size.height * 0.015),
                              DynamicInputWidget(
                                  controller: emailController,
                                  obscureText: false,
                                  currentFocusNode: emailFocusNode,
                                  toggleObscureText: toggleObscureText,
                                  validator: authValidators.emailValidator,
                                  hintText: 'Email',
                                  textInputAction: TextInputAction.next,
                                  isNonPasswordField: true),
                              SizedBox(height: size.height * 0.015),
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
                              SizedBox(height: size.height * 0.015),
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
                              SizedBox(height: size.height * 0.05),
                              
                            ],
                          )
                      )
                    )
                  ),
                  Positioned(
                    top: size.height- 300,
                    width: size.width,
                    child: Container(
                      child: Column( 
                        children: [
                          Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          fullName = fullNameController.text;
                          userName = usrNameController.text;
                          email = emailController.text;
                          password = passwordController.text;
                          register();
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.white,
                          backgroundColor:const Color.fromRGBO(185, 0, 182, 1),
                          foregroundColor:const Color.fromRGBO(233, 227, 227, 1),
                          disabledBackgroundColor:const Color.fromARGB(254, 255, 254, 254),
                          elevation: 2.0,
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                          textStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45)
                          )
                        ),
                        child: const Text(
                          'Sign Up',
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.1),
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
                  SizedBox(height: size.height * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton.filled(
                        style: Theme.of(context).iconButtonTheme.style,
                        color: Colors.red,
                        padding: const EdgeInsets.all(4),
                        onPressed: () {},
                        icon:const Icon(Icons.hail_outlined),
                        // icon: Image.asset(
                        //   'assets/images/twitter.png',
                        //   color: Colors.blue,
                          
                        // )
                        
                      ),
                      IconButton.filled(
                        style: Theme.of(context).iconButtonTheme.style,
                        padding: const EdgeInsets.all(4),
                        onPressed: () {},
                        icon:const Icon(Icons.hail_outlined),
                        // icon: Image.asset(
                        //   'assets/images/apple.png',
                        //   color: Colors.white,
                        // )
                      ),
                      IconButton.filled(
                        style: Theme.of(context).iconButtonTheme.style,
                        padding: const EdgeInsets.all(4),
                        onPressed: () {},
                        icon:const Icon(Icons.hail_outlined),
                        // icon: Image.asset(
                        //   'assets/images/google.png',
                        // )
                      ),
                    ],
                  ),
                        ],
                      ),
                    )
                  ),
                  
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
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MyLogin()));
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
                  )
                )
            ],
          ),
      ),
    );
  }

  Future <void> register() async {
    User? user;
    if (_key.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        user = await authService
          .registerUserWithEmailandPassword(fullName, email, password);
      } on FirebaseAuthException catch (e) {
        showWarning(context, e.message.toString());
        setState(() {
          _isLoading = false;
        });
      }
      if(user != null) {
        String uid = user.uid;
        DatabaseService.current_uid = uid;
        UserModel newUser = UserModel(
          uid: uid,
          email: email,
          userName: "",
          fullName: fullName,
          profilePic: "",
          password: password,
          background: "",
          freinds: {}
        );
        await DatabaseService.savingUserData(fullName,email,password).then((value) async{
          ref.read(userModelProviderState.notifier).state = newUser;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyHomePage(userModel: newUser)));
        });
      } 
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
            color: Colors.white38,
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
          errorStyle: const TextStyle(fontSize: 12)
        ),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
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
