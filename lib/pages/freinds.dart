import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Models/user_model.dart';
import 'package:firebase_app/Widgets/empty_tabs.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
 
class MyFreinds extends ConsumerStatefulWidget {
  const MyFreinds({super.key});
 
  @override
  ConsumerState<MyFreinds> createState() => _MyFreindsState();
}
class _MyFreindsState extends ConsumerState<MyFreinds> {

  bool requsts = false;
  bool pending = false;
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
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 30,),
                    Text(
                      'Freinds',
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
                  child: ClipRRect(
                    child:Padding(
                      padding:const EdgeInsets.only(top: 30, left: 20, bottom: 30),
                      child : Column(
                      children : [
                       // pending ? 
                      StreamBuilder(
                        stream: DatabaseService.userCollection.where('freinds', isEqualTo: true).snapshots(),
                        builder: (context, snapshot){
                          if(snapshot.connectionState == ConnectionState.active)  {
                            if(snapshot.hasData) {
                              QuerySnapshot freinds = snapshot.data as QuerySnapshot;

                              if(freinds.docs.isNotEmpty){
                                return ListView.builder(
                                  itemBuilder:
                                    (context, index) {
                                      // getting usermodel of snapshot
                                      UserModel userModel = UserModel.fromMap(
                                        freinds.docs[index].data() as Map<String, dynamic>);
                                      //extracting members of chatroom as map
                                      Map<String, dynamic> members = userModel.freinds!;
                                      // converting member id to list
                                      List<String> memberKeys = members.keys.toList();

                                      return FutureBuilder(
                                        future: DatabaseService.getUserDataByID(memberKeys[index]),
                                        builder: (context, userData) {
                                          if(userData.connectionState == ConnectionState.done){
                                            if(userData.data != null) {

                                              UserModel targetUser = userData.data as UserModel;
                                              return  ListTile(
                                                leading: Hero(
                                                  tag: 'freindpic$index',
                                                  child: const CircleAvatar(
                                                    radius: 24,
                                                  ),
                                                ),
                                                title: Text(
                                                  targetUser.fullName!,
                                                  style: Theme.of(context).textTheme.displaySmall
                                                ),
                                                // subtitle:Text( 
                                                //   chatRoomModel.lastMessage.toString(),
                                                //   overflow: TextOverflow.ellipsis,
                                                //   softWrap: true,
                                                //   maxLines: 1,
                                                //   style: Theme.of(context).textTheme.titleSmall,
                                                // ),
                                                //trailing:const Text('Time'),
                                                // onTap: () {
                                                //   Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //       builder: (context) => MyChatRoom(
                                                //         chatroom: chatRoomModel,
                                                //         user: userModel,
                                                //         targetUser: targetUser,
                                                //         heroId: index
                                                //       ),
                                                //     ),
                                                //   );
                                                // },
                                                minVerticalPadding: 20,
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
                                    itemCount: freinds.docs.length,
                                );
                              } else {
                                return emptyTabContent(tab: 'chats', text: "You don't have any freinds Go make some");
                              }
                            }else if(snapshot.hasError){
                              return  emptyTabContent(tab: 'chats', text: snapshot.error.toString());
                            }else {
                              return  emptyTabContent(tab: 'chats', text: "snapshot error");
                            }
                          }else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );

                          }
                        }
                      )
                      ]
                    )
                  )
                )
              )
              )
            )
          ],
        ),
      )
    );
  }
}