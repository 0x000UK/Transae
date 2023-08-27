import 'package:firebase_app/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Widgets/empty_tabs.dart';
import 'package:firebase_app/Models/chat_room_model.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:firebase_app/pages/chats.dart';
 
class MyChatPageTab extends StatefulWidget {
  const MyChatPageTab({super.key, required this.userModel});
 
  final UserModel userModel;
 
  @override
  State<MyChatPageTab> createState() => _MyChatPageTabState();
}
class _MyChatPageTabState extends State<MyChatPageTab> {
 
  @override
  Widget build(BuildContext context) {
 
    return StreamBuilder(
        stream: DatabaseService.chatsCollection.where('members.${widget.userModel.uid}', isEqualTo: true).snapshots(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.active)  {
            if(snapshot.hasData) {
              QuerySnapshot chatRoomSnapshot = snapshot.data as QuerySnapshot;

              if(chatRoomSnapshot.docs.isNotEmpty){
                return  //ListView.builder(itemBuilder:
                 SliverList(
                   delegate: SliverChildBuilderDelegate( 
                    (context, index) {
                      // getting chatroommodel of snapshot
                      ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                        chatRoomSnapshot.docs[index].data() as Map<String, dynamic>);
                      //extracting members of chatroom as map
                      Map<String, dynamic> members = chatRoomModel.members!;
                      // converting member id to list
                      List<String> memberKeys = members.keys.toList();

                      // remove my key so that i know who is the other person
                      memberKeys.remove(widget.userModel.uid);

                      return FutureBuilder(
                        future: DatabaseService.getUserDataByID(memberKeys[0]),
                        builder: (context, userData) {
                          if(userData.connectionState == ConnectionState.done){
                            // print("userdata connection done");
                            if(userData.data != null) {

                              UserModel targetUser = userData.data as UserModel;
                              return  ListTile(
                                leading: Hero(
                                  tag: 'profilepic$index',
                                  child: const CircleAvatar(
                                    radius: 30,
                                  ),
                                ),
                                title: Text(
                                  targetUser.fullName!,
                                  style:const TextStyle(fontSize: 20),
                                ),
                                subtitle:Text( 
                                  chatRoomModel.lastMessage.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 1,
                                ),
                                trailing:const Text('Time'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyChatRoom(
                                        chatroom: chatRoomModel,
                                        user: widget.userModel,
                                        targetUser: targetUser,
                                        heroId: index
                                      ),
                                    ),
                                  );
                                },
                              );
                            }else {
                              return emptyTabContent(tab: 'chats', text: "no user data");
                            }
                          }else{
                            return const Center(
                                child: CircularProgressIndicator(),
                              );
                            
                          }
                        }
                      );  
                    },
                    childCount: chatRoomSnapshot.docs.length,
                  ),
                );
              } else {
                return SliverToBoxAdapter(child: emptyTabContent(tab: 'chats', text: "no data in database"));
              }
            }else if(snapshot.hasError){
              return SliverToBoxAdapter(child: emptyTabContent(tab: 'chats', text: snapshot.error.toString()));
            }else {
              return SliverToBoxAdapter(child : emptyTabContent(tab: 'chats', text: "snapshot error"));
            }
          }else {
            return const SliverToBoxAdapter(child: Center(
              child: CircularProgressIndicator(),
            )
            );

          }
        }
      );
  }
}