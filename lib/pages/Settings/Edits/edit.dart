import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Models/user_model.dart';
import 'package:firebase_app/Widgets/warnings.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:firebase_app/service/Provider/provider.dart';
import 'package:firebase_app/service/auth_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
class MyEdits extends ConsumerStatefulWidget {
  const MyEdits({super.key,required this.edit, required this.userModel});

  final String edit;
  final UserModel? userModel;
  @override
  ConsumerState<MyEdits> createState() => _MyEditsState();
}
class _MyEditsState extends ConsumerState<MyEdits> {
  
  late TextEditingController _controller;
  late FocusNode userNameFocusNode;
  bool showSaveButton = false;
  UserModel? userModel;

    @override
  void initState() {
    super.initState();
    // userModel = ref.watch(userModelProviderState.notifier).state;
    switch (widget.edit) {
      case "UserName":  _controller = TextEditingController(text: widget.userModel!.userName);
        break;
      case "FullName" : _controller = TextEditingController(text: widget.userModel!.fullName);
        break;
      case "Email" : _controller = TextEditingController(text: widget.userModel!.email);
        break;
      case "Password" : _controller = TextEditingController();
        break;
      default: _controller = TextEditingController();
        break;
    }
    userNameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    userNameFocusNode.dispose();
    super.dispose();
  }
 
  
  @override
  Widget build(BuildContext context) {
    userModel = ref.watch(userModelProviderState.notifier).state;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        height: size.height,
        child: Column(
          children: [
            SafeArea(
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    IconButton(
                      splashRadius: 1,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 30,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      widget.edit == "UserName" ? 'User Name' :
                      widget.edit == "FullName" ? 'Full Name' :
                      widget.edit == "Email" ? 'Email' :
                      widget.edit == "Password" ? 'Password' :
                      '',
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  ],
                )
              ),
            ),
            Expanded(
              child: Padding(
                padding:const EdgeInsets.all(15),
                child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: const BorderRadius.all(Radius.circular(30))

                ),
                child: Column(
                  children: [
                    Padding(
                      padding:const EdgeInsets.only(top: 40, left: 20, right: 20),
                      child : TextField(
                        cursorColor: Colors.white38,
                        undoController: UndoHistoryController(),
                        controller: _controller,
                        style: Theme.of(context).textTheme.bodyLarge,
                        decoration:  InputDecoration(
                          border: const UnderlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          labelText: 
                            widget.edit == "UserName" ? 'Enter userName' :
                            widget.edit == "FullName" ? 'Enter Fullname' :
                            widget.edit == "Email" ? 'Enter Email' :
                            widget.edit == "Password" ? 'Enter Current Password' :
                            "",
                          labelStyle: Theme.of(context).textTheme.bodyMedium
                        ),
                        onTapOutside: (event) {
                          userNameFocusNode.unfocus();
                        },
                        onTap: () {
                          userNameFocusNode.requestFocus();
                        },
                        onChanged: (value) {
                          setState(() {
                            showSaveButton = true;
                            if(_controller.text.isEmpty) {
                              showSaveButton = false;
                            }
                            if(_controller.text == userModel!.userName){
                              showSaveButton = false;
                            }
                          });
                        },
                        onSubmitted:(value) {
                          _controller.text = value.trim();
                          
                        },
                      ),
                    ),
                    widget.edit == "Password" ? Padding(
                      padding:const EdgeInsets.only(top: 40, left: 20, right: 20),
                      child : TextField(
                        cursorColor: Colors.white38,
                        undoController: UndoHistoryController(),
                        controller: _controller,
                        style: const TextStyle(fontSize: 20),
                        decoration: const  InputDecoration(
                          border:  UnderlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding:   EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          labelText: 
                             'Enter New Password', 
                          labelStyle:  TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(123, 0, 0, 0),
                          ),
                        ),
                        onTapOutside: (event) {
                          userNameFocusNode.unfocus();
                        },
                        onTap: () {
                          userNameFocusNode.requestFocus();
                        },
                        onChanged: (value) {
                          setState(() {
                            showSaveButton = true;
                            if(_controller.text.isEmpty) {
                              showSaveButton = false;
                            }
                            if(_controller.text == userModel!.userName){
                              showSaveButton = false;
                            }
                          });
                        },
                      ),
                    ) : Container(),
                    // const SizedBox(height: 550,),
                    Expanded(
                      child: showSaveButton? AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.decelerate,
                        padding: const EdgeInsets.only(right: 20,bottom: 20),
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton.extended(
                          onPressed: () async {
                            //UserModel updatedUserModel;
                            switch (widget.edit) {
                              case "UserName":  await updateUserData(_controller.text);
                                  ref.read(userModelProviderState.notifier).state!.userName = _controller.text;
                                
                                break;
                              case "FullName" : await updateUserData(_controller.text);
                                  ref.read(userModelProviderState.notifier).state!.fullName = _controller.text;
                                break;
                              case "Email" : await updateUserData(_controller.text);
                                  ref.read(userModelProviderState.notifier).state!.email = _controller.text;
                                break;
                              case "Password" : await updateUserData(_controller.text);
                                ref.read(userModelProviderState.notifier).state!.password = _controller.text;
                                break;
                              default:
                                break;
                            }
                             Navigator.of(context).pop();
                          }, 
                          label: const Text("Save", style: TextStyle(fontSize: 15),),
                          icon: const Icon(Icons.save, size: 30,),
                          shape:const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                        ),
                      ): const SizedBox()
                    )
                  ],
                )
              )
            )
          )
          ],
        ),
      )
    );
  }

  Future<void> updateUserData(String inputText) async {
    try {
      // Check if the new username already exists
      QuerySnapshot querySnapshot;
      if(widget.edit == "UserName") {
        querySnapshot = await DatabaseService.userCollection.where('userName', isEqualTo: inputText).get();
        if (querySnapshot.docs.isEmpty) {
          // Update the user's username
          DocumentReference userDocRef = DatabaseService.userCollection.doc(userModel!.uid);
          await userDocRef.update({
            'userName': inputText,
          });
          showWarning(context, "successfully updated Useraname");
        } else {
          showWarning(context, "Username not availbale, Try different one");
        }
      } else if (widget.edit == "Email"){
        querySnapshot = await DatabaseService.userCollection.where('email', isEqualTo: inputText).get();
        if (querySnapshot.docs.isEmpty) {
          // Update the user's username
          DocumentReference userDocRef = DatabaseService.userCollection.doc(userModel!.uid);
          await userDocRef.update({
            'email': inputText,
          });
          showWarning(context, "successfully updated Email");
        } else {
          showWarning(context, "Email already registered!!");
        }
      }else if(widget.edit == 'FullName') {
        DocumentReference userDocRef = DatabaseService.userCollection.doc(userModel!.uid);
        await userDocRef.update({
          'fullName': inputText,
        });
        showWarning(context, "successfully updated FullName");
      }else {
        DocumentReference userDocRef = DatabaseService.userCollection.doc(userModel!.uid);
        await userDocRef.update({
          'password': inputText,
        });
        showWarning(context, "successfully updated Password");
      }
      
    } catch (e) {
      showWarning(context, e);
    }
  }
}