import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Models/user_model.dart';
import 'package:firebase_app/Models/chat_room_model.dart';
import 'package:firebase_app/Models/message_model.dart';
import 'package:firebase_app/Models/message_type.dart';
import 'package:firebase_app/Widgets/colors.dart';
import 'package:firebase_app/Widgets/message_boxes.dart';
import 'package:firebase_app/main.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
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
 
    return Scaffold(
      backgroundColor: ThemeColors.orange,
        
      body: Column(
        children: [

          Container(
            decoration:const BoxDecoration(
              color:  ThemeColors.orange
            ),
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back,color: Colors.black,),
                ),
                const SizedBox(width: 2),
                Hero(
                  tag: 'profilepic${widget.heroId}',
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundImage:NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
                  ),
                ),
                const SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.targetUser.fullName!, style: const TextStyle( fontSize: 20 ,fontWeight: FontWeight.w600),),
                      const SizedBox(height: 6,),
                      Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 15),),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: (){}, 
                  icon: const Icon(Icons.more_vert,color: Colors.black54),
                  iconSize: 30,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(padding: const EdgeInsets.all(15),
              child: Container(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),
                color: ThemeColors.lightorange,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child : chatMessages()
                ),
              ),
            )
          ),
          Container(
            color:ThemeColors.orange,
            padding: const EdgeInsets.only(bottom: 10),
            child: Row (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children : [
                SizedBox(  
                  width: MediaQuery.of(context).size.width-90,
                  height: 60,
                  child : TextField(
                    controller: mssgController,
                    maxLines: null,
                    expands: true,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                    contentPadding:  EdgeInsets.symmetric(vertical: 18.0, horizontal: 30.0),
                    hintText: 'Enter text...',
                    fillColor: ThemeColors.lightorange,
                    filled: true,
                    hintStyle:  TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(123, 0, 0, 0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      ),
                    ),
                    onTapOutside: (event) {
                      msgFocusNode.unfocus();
                    },
                  ),
              ),
              Padding(
                padding:const EdgeInsets.only(bottom: 1),
                child : Container(
                  decoration:const BoxDecoration(
                    color: ThemeColors.lightorange,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0)
                    )
                  ),
                  child: IconButton(
                    color: ThemeColors.redorange,
                    onPressed: (){
                      sendMessage(_isFirstMessage);
                      setState(() {
                        _isFirstMessage = false;
                      });
                    }, 
                    icon:const Icon(Icons.send), 
                    iconSize: 43,
                  )
                ),
                )
              ]
            )
          )
        ],
      ),
      
    );
  }

  sendMessage(bool isFirstMessage) async {
    String msg = mssgController.text.trim();
    mssgController.clear();
    
    // dynamic req = await Chat.sendRequest(msg, "english");
    // if (req != null ) {
    //   msg = req;
    // }

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
              child: Text("${snapshot.error.toString()}\nplease check your internet connection "),
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

 
