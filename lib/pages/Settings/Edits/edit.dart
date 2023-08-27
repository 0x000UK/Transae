import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Models/user_model.dart';
import 'package:firebase_app/Widgets/colors.dart';
import 'package:firebase_app/Widgets/warnings.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:firebase_app/service/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
class MyEdits extends ConsumerStatefulWidget {
  const MyEdits({super.key, required this.userModel});

  final UserModel? userModel;
  @override
  ConsumerState<MyEdits> createState() => _MyEditsState();
}
class _MyEditsState extends ConsumerState<MyEdits> {
  
  late TextEditingController userNameController;
  late FocusNode userNameFocusNode;
  bool showSaveButton = false;
  UserModel? userModel;

    @override
  void initState() {
    super.initState();
    // userModel = ref.watch(userModelProviderState.notifier).state;
    userNameController = TextEditingController(text: widget.userModel!.userName);
    userNameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    userNameFocusNode.dispose();
  }
 
  
  @override
  Widget build(BuildContext context) {
    userModel = ref.watch(userModelProviderState.notifier).state;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeColors.orange,
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
                    const Text(
                      'User Name',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ),
            ),
            Expanded(
              child: Padding(
                padding:const EdgeInsets.all(15),
                child: Container(
                decoration: const BoxDecoration(
                  color: ThemeColors.lightorange,
                  borderRadius: BorderRadius.all(Radius.circular(30))

                ),
                child: Column(
                  children: [
                    Padding(
                      padding:const EdgeInsets.only(top: 40, left: 20, right: 20),
                      child : TextField(
                        cursorColor: Colors.white38,
                        undoController: UndoHistoryController(),
                        controller: userNameController,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          border:UnderlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding:  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          labelText: 'Enter userName',
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
                            if(userNameController.text.isEmpty) {
                              showSaveButton = false;
                            }
                            if(userNameController.text == userModel!.userName){
                              showSaveButton = false;
                            }
                          });
                        },
                        onSubmitted:(value) {
                          userNameController.text = value.trim();
                          
                        },
                      ),
                    ),
                    // const SizedBox(height: 550,),
                    Expanded(
                      child: showSaveButton? AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.decelerate,
                        padding: const EdgeInsets.only(right: 20,bottom: 20),
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton.extended(
                          onPressed: () async {
                            await updateUsername(userNameController.text);
                            UserModel updatedUserModel = 
                            UserModel(
                              uid: userModel!.uid,
                              userName: userNameController.text,
                              fullName: userModel!.fullName,
                              profilePic: userModel!.profilePic,
                              email: userModel!.email
                              );
                            ref.read(userModelProviderState.notifier).state = updatedUserModel;
                          }, 
                          label: const Text("Save", style: TextStyle(fontSize: 15),),
                          icon: const Icon(Icons.save, size: 30,),
                          shape:const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                        ),
                      ): Container()
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

  Future<void> updateUsername(String newUsername) async {
    try {
      // Check if the new username already exists
      QuerySnapshot querySnapshot = await DatabaseService.userCollection.where('userName', isEqualTo: newUsername).get();

      // If the querySnapshot is empty, the username is available
      if (querySnapshot.docs.isEmpty) {
        // Update the user's username
        DocumentReference userDocRef = DatabaseService.userCollection.doc(userModel!.uid);
        await userDocRef.update({
          'userName': newUsername,
        });
        showWarning(context, "successfully updated Useraname");
        Navigator.of(context).pop();
      } else {
        showWarning(context, "Username not availbale, Try different one");
      }
    } catch (e) {
      showWarning(context, e);
    }
  }

}