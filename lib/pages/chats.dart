import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Models/user_model.dart';
import 'package:firebase_app/Models/chat_room_model.dart';
import 'package:firebase_app/Models/message_model.dart';
import 'package:firebase_app/Models/message_type.dart';
import 'package:firebase_app/Widgets/colors.dart';
import 'package:firebase_app/Widgets/message_boxes.dart';
import 'package:firebase_app/main.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:firebase_app/service/Translate/gpt_3.dart';
import 'package:flutter/material.dart';

class MyChatRoom extends StatefulWidget {
  const MyChatRoom({
    super.key, 
    required this.chatroom, 
    required this.targetUser, 
    required this.user,
    required this.heroId
  });

  final ChatRoomModel chatroom;
  final UserModel user;
  final UserModel targetUser;
  final int heroId;

  @override
  State<MyChatRoom> createState() => _MyChatRoom();
}
class _MyChatRoom extends State<MyChatRoom> {

  late TextEditingController mssgController;
  late FocusNode msgFocusNode;

  @override
  void initState() {
    mssgController = TextEditingController();
    msgFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    mssgController.dispose();
    msgFocusNode.dispose();
  }

  bool _isFirstMessage = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        
      body: Column(
        children: [

          Container(
            decoration: BoxDecoration(
              color:  Theme.of(context).scaffoldBackgroundColor
            ),
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                Hero(
                  tag: 'profilepic${widget.heroId}',
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundImage:NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.targetUser.fullName!, style: Theme.of(context).textTheme.titleMedium),
                      Text("Online",style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: (){}, 
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          
          Expanded(
            child : Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: Theme.of(context).primaryColorLight,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child : chatMessages()
                ),
              ),
            ),
          ),
          Container(
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.grey),
            // ),
            padding:const  EdgeInsets.only(left: 15, right: 15, bottom:  10),      
            child: Row( 
              children: [
                Expanded(child: 
                  TextField(
                    controller: mssgController,
                    maxLines: 5,
                    minLines: 1,
                    expands: false,
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration:  InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                    hintText: 'Enter text...',
                    fillColor: Theme.of(context).primaryColorLight,
                    filled: true,
                    //hintStyle: Theme.of(context).textTheme.bodySmall,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                    prefixIcon: IconButton(onPressed:(){}, icon: const Icon(Icons.emoji_emotions_outlined), color: Theme.of(context).iconTheme.color,) ,
                    suffixIcon: IconButton(onPressed:(){}, icon: const Icon(Icons.attachment_outlined), color: Theme.of(context).iconTheme.color)
                    ),
                    onTapOutside: (event) {
                      msgFocusNode.unfocus();
                    },
                    
                  ),
                ),
                const SizedBox(width: 5,),
                Container(
                  decoration:  BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                     
                    shape: BoxShape.circle,
                    //borderRadius: BorderRadius.circular(12)
                    // BorderRadius.only(
                    //   topRight: Radius.circular(30.0),
                    //   bottomRight: Radius.circular(30.0)
                    // )
                  ),
                  child :
                   Center( child : IconButton(
                    color: LightThemeColors.redorange,
                    onPressed: (){
                      sendMessage(_isFirstMessage);
                      setState(() {
                        _isFirstMessage = false;
                      });
                    }, 
                    icon:const Icon(Icons.send), 
                    iconSize: 30,
                  ),
                   )
                )
                
                ]
                )
            )
        ]
      )
    );
  }

  sendMessage(bool isFirstMessage) async {
    String msg = mssgController.text.trim();
    mssgController.clear();
    
    dynamic req = await Chat.sendMessage(msg, "english");
    if (req != null ) {
      msg = req;
    }

    if (msg.isNotEmpty) {
      MessageModel newMessage = MessageModel(
        senderId: widget.user.uid!, 
        receiverId: widget.targetUser.uid!, 
        textMessage: msg, 
        type: MessageType.text, 
        timeSent: DateTime.now(), 
        messageId: uuid.v1(),
        isSeen: false
      );

    if(isFirstMessage) {
      DatabaseService.chatsCollection.doc(widget.chatroom.chatroomid!).update({ "members.${widget.targetUser.uid!}": true});
    }

    DatabaseService.chatsCollection.doc(widget.chatroom.chatroomid!)
    .update({ 
      "lastmessage": newMessage.textMessage,
    });
    DatabaseService.savingChatData(widget.chatroom.chatroomid!, newMessage.messageId, newMessage);
    }
  }

  chatMessages() {
    return StreamBuilder(
      stream: DatabaseService.getchats(widget.chatroom.chatroomid!),
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.active){
          if(snapshot.hasData) {

            QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;
            return ListView.builder(
              reverse: true,
              itemBuilder: (context, index){

                MessageModel currentMessage = MessageModel.fromMap(dataSnapshot.docs[index].data() as Map<String, dynamic>);
                return MessageBox(
                  message: currentMessage.textMessage, 
                  senderId: currentMessage.senderId, 
                  currentUser: widget.user.uid!,
                );
              },
              itemCount: dataSnapshot.docs.length
              );
          }else if(snapshot.hasError){
            return  Center(
              child: Text("${snapshot.error.toString()}\n please check your internet connection "),
            );
          }else {
            return const Center(
              child: Text("No messages"),
            );
          }
        }
        else{
          return const Center (
            child: CircularProgressIndicator(),
          );
        }

      }
        
    );
  }
}

 
