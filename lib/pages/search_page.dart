import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Models/UserModel.dart';
import 'package:firebase_app/Models/chat_room_model.dart';
import 'package:firebase_app/main.dart';
import 'package:firebase_app/pages/chats.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:flutter/material.dart';

class MysearchPage extends StatefulWidget {
  const MysearchPage({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<MysearchPage> createState() => _MysearchPageState();
}

class _MysearchPageState extends State<MysearchPage> {

  late TextEditingController searchController;
  late FocusNode searchfocusNode;
  bool searching =  false;

  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchfocusNode = FocusNode();
  }

  Future<ChatRoomModel?> getChatRoomModel (UserModel targetUser) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await DatabaseService.chatsCollection.
    where("members.${widget.userModel.uid}", isEqualTo: true).
    where("members.${targetUser.uid}", isEqualTo: true).get();

    if(snapshot.docs.isNotEmpty) {
      // Fetch the existing one
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom = ChatRoomModel.fromMap(docData as Map<String, dynamic>);

      chatRoom = existingChatroom;
    }
    else {
      // Create a new one
      ChatRoomModel newChatroom = ChatRoomModel(
        chatroomid: uuid.v1(),
        lastMessage: "",
        members: {
          widget.userModel.uid.toString(): true,
          targetUser.uid.toString(): true,
        },
      );
      await DatabaseService.chatsCollection.doc(newChatroom.chatroomid).set(newChatroom.toMap());

      chatRoom = newChatroom;
    }
    return chatRoom;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 151, 151),
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
                      'Add Members',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
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
                          Image.asset(
                            'assets/images/search.png',
                            scale: 3.5,
                          ),
                          const SizedBox(height: 50),
                          const Text(
                            'Add members on BoomBam',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'Search users using there Email or UserName',
                            maxLines: null,
                            style: TextStyle(
                              fontSize: 15,
                              //decoration: TextDecoration.lineThrough
                            ),
                          ),
                          const Text(
                            'Keep in mind username is case sensitive',
                            maxLines: null,
                            style: TextStyle(
                              fontSize: 15,
                              //decoration: TextDecoration.lineThrough
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            color: const Color.fromARGB(
                                255, 255, 151, 151),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 12),
                                  width: MediaQuery.of(context).size.width-140,
                                  height: 75,
                                  child: TextField(
                                    focusNode: searchfocusNode,
                                    controller: searchController,
                                    style: const TextStyle(fontSize: 18),
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color.fromARGB(
                                          200, 255, 186, 186),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          bottomLeft:
                                              Radius.circular(30.0),
                                        ),
                                      ),
                                      hintText: 'Email or Username',
                                      helperText:
                                          'e.g user_Name11 or xyz@gmail.com',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    onTapOutside: (event) {
                                      searchfocusNode.unfocus();
                                    },
                                    cursorColor: Colors.black87,
                                  ),
                                ),
                                Padding(
                                  padding:const EdgeInsets.only(bottom: 22),
                                  child: Container(
                                    width: 80,
                                    height: 52,
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(
                                            230, 76, 242, 206),
                                        borderRadius: BorderRadius.only(
                                            topRight:
                                                Radius.circular(30.0),
                                            bottomRight:
                                                Radius.circular(30.0))),
                                    child: IconButton(
                                      splashRadius: 1,
                                      onPressed: () {
                                        setState(() { searching = true;});
                                      },
                                      icon: const Icon(
                                        Icons.search,
                                        size: 30,
                                      ),
                                      color: const Color.fromARGB(
                                          255, 255, 151, 151),
                                    ),
                                  )
                                )
                              ]
                            )
                          ),
                          const SizedBox(height: 40),
                          searching? StreamBuilder(
                            stream: searchController.text.contains('@')? 
                                    DatabaseService.userCollection.where('email', isEqualTo: searchController.text).where('email', isNotEqualTo: widget.userModel.email).snapshots(): 
                                    DatabaseService.userCollection.where('username', isEqualTo: searchController.text).snapshots(),

                            builder: (context, snapshot){
                              if(snapshot.connectionState == ConnectionState.active){
                                if(snapshot.hasData){

                                  QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                                  if(dataSnapshot.docs.isNotEmpty) {

                                    Map<String,dynamic> userMap = dataSnapshot.docs[0].data() as Map<String, dynamic>;
                                    UserModel searchedUser = UserModel.fromMap(userMap);
                                    return Container(
                                      width: size.width-50,
                                      height: 100,
                                      padding:const EdgeInsets.all(0),
                                    child : ListTile(
                                      leading: const Hero(
                                        tag: 0,
                                        child: CircleAvatar(
                                          radius: 28,
                                          //backgroundImage:NetworkImage(),
                                        ),
                                      ),

                                      title: Text(searchedUser.fullName!),
                                      subtitle: Text(searchedUser.email!),
                                      trailing: SizedBox(
                                        width: 50,
                                        height: 50,
                                      child : Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //crossAxisAlignment: CrossAxisAlignment.baseline,
                                        children: [
                                          IconButton(
                                            onPressed: (){}, 
                                            icon:const Icon(Icons.person_add_alt),
                                            iconSize: 30,
                                          ),
                                          SizedBox(width: 5,),
                                          IconButton(
                                            onPressed: (){}, 
                                            icon:const Icon(Icons.chat_outlined),
                                            iconSize: 30,
                                          )
                                        ]
                                      ),
                                      ),
                                      onTap: () async {
                                        ChatRoomModel? chatRoomModel = await getChatRoomModel(searchedUser);

                                         if(chatRoomModel != null) {
                                            Navigator.pop(context);
                                            Navigator.push(context, MaterialPageRoute(
                                              builder: (context) {
                                                return MyChatRoom(
                                                  targetUser: searchedUser,
                                                  user: widget.userModel,
                                                  chatroom: chatRoomModel,
                                                  heroId: 0,
                                                );
                                              }
                                            ));
                                          }
                                      },
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
}
