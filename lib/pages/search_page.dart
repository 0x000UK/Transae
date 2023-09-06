import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Models/user_model.dart';
import 'package:firebase_app/Models/chat_room_model.dart';
import 'package:firebase_app/Widgets/colors.dart';
import 'package:firebase_app/Widgets/warnings.dart';
import 'package:firebase_app/pages/chats.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:firebase_app/service/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MysearchPage extends ConsumerStatefulWidget {
  const MysearchPage({super.key, required this.userModel});

  final UserModel userModel;

  @override
  ConsumerState<MysearchPage> createState() => _MysearchPageState();
}

class _MysearchPageState extends ConsumerState<MysearchPage> {

  late TextEditingController searchController;
  late FocusNode searchfocusNode;
  bool searching =  false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchfocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
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
                      'Add Members',
                      style:  Theme.of(context).textTheme.displayMedium
                    )
                  ],
                )
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: SizedBox(
                  height: size.height - 90,
                  child: Stack(
                    children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //SizedBox.shrink(child: SizedBox(height: 100,),),
                        children: [
                          const SizedBox(height: 80),
                          Image.asset(
                            'assets/images/search.png',
                            scale: 3.5,
                          ),
                          const SizedBox(height: 50),
                          Text(
                            'Add members on BoomBam',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            'Search users using there Email or UserName. Keep',
                            maxLines: null,
                            style: Theme.of(context).textTheme.titleSmall
                          ),
                          Text(
                            'in mind username is case sensitive',
                            maxLines: null,
                            style: Theme.of(context).textTheme.titleSmall
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.only(left: 0),
                            color:Theme.of(context).scaffoldBackgroundColor,
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 12),
                                  width: MediaQuery.of(context).size.width-100,
                                  height: size.height*0.06,
                                  child: TextField(
                                    focusNode: searchfocusNode,
                                    controller: searchController,
                                    style: const TextStyle(fontSize: 16),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Theme.of(context).primaryColorLight,
                                      border:const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          bottomLeft: Radius.circular(30.0),
                                        ),
                                        
                                      ),
                                      contentPadding: const EdgeInsets.only(left: 20),
                                      hintText: 'Email or Username',
                                      hintStyle: const TextStyle(color: Colors.black45, fontSize: 16),
                                      //helperText: 'e.g user_Name11 or xyz@gmail.com',
                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                    ),
                                    onTapOutside: (event) {
                                      searchfocusNode.unfocus();
                                    },
                                    cursorColor: Colors.black87,
                                  ),
                                ),
                                // Padding(
                                //   padding:const EdgeInsets.only(bottom: 24.5),
                                // child:
                                 
                                  Container(
                                    width: 80,
                                    height: size.height*0.06,
                                    decoration: const BoxDecoration(
                                        color: LightThemeColors.aqua,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30.0),
                                            bottomRight: Radius.circular(30.0))),
                                    child: IconButton(
                                      splashRadius: 1,
                                      onPressed: () {
                                        setState(() { searching = true;});
                                        //
                                      },
                                      icon: const Icon(
                                        Icons.search,
                                        size: 30,
                                      ),
                                      color: LightThemeColors.orange
                                    ),
                                  )
                                // )
                              ]
                            )
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text('e.g user_Name11 or xyz@gmail.com',style: Theme.of(context).textTheme.titleSmall)
                          ),
                          const SizedBox(height: 10),
                          searching? StreamBuilder(
                            stream: searchController.text.contains('@')? 
                                    DatabaseService.userCollection.where('email', isEqualTo: searchController.text.trim()).where('email', isNotEqualTo: widget.userModel.email).snapshots(): 
                                    DatabaseService.userCollection.where('userName', isEqualTo: searchController.text.trim()).snapshots(),

                            builder: (context, snapshot){
                              if(snapshot.connectionState == ConnectionState.active){
                                if(snapshot.hasData){

                                  QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                                  if(dataSnapshot.docs.isNotEmpty) {

                                    Map<String,dynamic> userMap = dataSnapshot.docs[0].data() as Map<String, dynamic>;
                                    UserModel searchedUser = UserModel.fromMap(userMap);
                                    
                                    return Padding(
                                      //width: size.width,
                                      //height: 80,
                                      padding:const EdgeInsets.all(15),
                                    
                                    child: ListTile(
                                      leading: const Hero(
                                        tag: 0,
                                        child: CircleAvatar(
                                          radius: 22,
                                          //backgroundImage:NetworkImage(),
                                        ),
                                      ),
                                     // minVerticalPadding: 1,
                                      title: Text(searchedUser.fullName!, style: Theme.of(context).textTheme.displaySmall),
                                      subtitle: Text(searchedUser.email!,  style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis,),
                                      trailing: Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //crossAxisAlignment: CrossAxisAlignment.baseline,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: (){
                                              ref.read(friendRequestProvider.notifier).state.add(searchedUser);
                                              sendRequest(searchedUser.uid);
                                            }, 
                                            icon:const Icon(Icons.person_add_alt),
                                            iconSize: 20,
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                               ChatRoomModel? chatRoomModel = await DatabaseService.getChatRoomModel(searchedUser);
                                              if(chatRoomModel != null) {
                                                  Navigator.pop(context);
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.push(context, MaterialPageRoute(
                                                    builder: (context) {
                                                      return MyChatRoom(
                                                        targetUser: searchedUser,
                                                        user: widget.userModel,
                                                        chatroom: chatRoomModel,
                                                        heroId: 0,
                                                      );
                                                    }
                                                  )
                                                );
                                              }
                                            }, 
                                            icon:const Icon(Icons.chat_outlined),
                                            iconSize: 20,
                                          )
                                        ]
                                      ),
                                    )
                                    );

                                  }else{
                                    return const Text('No Results Found');
                                  }
                                }
                                else if (snapshot.hasError){
                                  return  Text(snapshot.error.toString());
                                }
                                else{
                                  return const Text('No Results found');
                                }
                              }else {
                                return Container();
                              }
                            }
                          ): Container()
                        ]
                      )
                    ]
                  ),
                )
              )
            )
          ],
        ),
      )
    );
  }
  sendRequest(targetuserid) async {
    //final  querySnapshot = await DatabaseService.userCollection.doc(targetuser).get();

     DocumentReference userDocRef = DatabaseService.userCollection.doc(targetuserid);

    try {
      await userDocRef.update({
        // Use square brackets to set a new key-value pair in the map
        'friends.$targetuserid': false,
      });
      showWarning(context,'Friend added successfully');
    } catch (e) {
      showWarning(context,'Some Error occured : $e');
    }
  }
}
