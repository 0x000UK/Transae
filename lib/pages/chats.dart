import 'package:firebase_app/Models/UserModel.dart';
import 'package:firebase_app/Models/chat_room_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/Models/messageModel.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
class ChatMessage{
  String messageContent;
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType});
}

class MyMessagesPage extends StatefulWidget {
  const MyMessagesPage({
    super.key, 
    required this.chatroom, 
    required this.targetUser, 
    required this.user
  });

  final ChatRoomModel chatroom;
  final UserModel user;
  final UserModel targetUser;

  @override
  State<MyMessagesPage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyMessagesPage> {

  //Stream<QuerySnapshot>
  late TextEditingController mssgController;

  @override
  void initState() {
    mssgController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    mssgController.dispose();
  }

  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Alexe, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
 
    // return Scaffold(
    //   backgroundColor:const  Color.fromARGB(255, 255, 151, 151),
        
    //   body: Column(
    //     children: [

    //       Container(
    //         decoration:const BoxDecoration(
    //           color:  Color.fromARGB(255, 255, 151, 151)
    //         ),
    //         padding: const EdgeInsets.only(top: 50),
    //         child: Row(
    //           children: <Widget>[
    //             IconButton(
    //               onPressed: (){
    //                 Navigator.pop(context);
    //               },
    //               icon: const Icon(Icons.arrow_back,color: Colors.black,),
    //             ),
    //             const SizedBox(width: 2,),
    //             Hero(
    //               tag: 'profilepic${widget.id}',
    //               child: const CircleAvatar(
    //                 radius: 28,
    //                 backgroundImage:NetworkImage(
    //                     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
    //               ),
    //             ),
    //             const SizedBox(width: 12,),
    //             Expanded(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: <Widget>[
    //                   Text(widget.name, style: const TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
    //                   const SizedBox(height: 6,),
    //                   Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
    //                 ],
    //               ),
    //             ),
    //             IconButton(
    //               onPressed: (){}, 
    //               icon: const Icon(Icons.more_vert,color: Colors.black54),
    //               iconSize: 30,
    //             ),
    //           ],
    //         ),
    //       ),
    //       Expanded(
    //         child: Padding(padding: const EdgeInsets.all(10),
    //         child: Container(
    //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
    //           color: const Color.fromARGB(200, 255, 186, 186),
    //           ),
    //           child:chatMessages()
    //         ),
    //         )
    //       ),
    //       Container(
    //         color:const Color.fromARGB(255, 255, 151, 151),
    //         child: Row (
    //           children : [
    //             Container(
    //               padding: EdgeInsets.only(left: 12),  
    //               width: MediaQuery.of(context).size.width-80,
    //               height: 75,
    //               child :
    //             TextField(
    //               controller: mssgController,
    //               maxLines: null,
    //               decoration: const InputDecoration(
    //               contentPadding:  EdgeInsets.symmetric(vertical: 18.0, horizontal: 30.0),
    //               hintText: 'Enter text....',
    //               fillColor: Color.fromARGB(234, 165, 126, 126),
    //               filled: true,
    //               hintStyle:  TextStyle(
    //                 fontSize: 20,
    //                 color: Color.fromARGB(123, 0, 0, 0),
    //               ),
    //               border: OutlineInputBorder(
    //                 borderSide: BorderSide.none,
    //                 borderRadius: BorderRadius.all(Radius.circular(45.0)),
    //               ),
    //             ),
    //           ),
    //             ),
    //             const SizedBox(width: 10),
    //             Padding(padding:const EdgeInsets.only(bottom: 20),
    //             child : IconButton(
    //               onPressed: (){sendMessage();}, 
    //               icon:const Icon(Icons.send), 
    //               iconSize: 40,
    //             ),
    //             )
    //           ]
    //         )
    //       )
    //     ],
    //   ),
      
    // );
  }
  //   chatMessages() {
  //   return StreamBuilder(
  //     //stream: chats,
  //     builder: (context, AsyncSnapshot snapshot) {
  //       return snapshot.hasData
  //           ? ListView.builder(
  //               itemCount: snapshot.data.docs.length,
  //               itemBuilder: (context, index) {
  //                 return MessageModel(
  //                     message: snapshot.data.docs[index]['message'],
  //                     sender: snapshot.data.docs[index]['sender'],
  //                     sentByMe: widget.name ==
  //                         snapshot.data.docs[index]['sender'],
  //                     time: ,);
  //               },
  //             )
  //           : Container();
  //     },
  //   );
  // }

  //  sendMessage() async {
  //   if (mssgController.text.isNotEmpty) {

  //     MessageModel newMessage = MessageModel(
  //       message: mssgController.text.trim(), 
  //       sender: sender, 
  //       sentByMe: sentByMe, 
  //       time: time
  //     )
  //     // Map<String, dynamic> chatMessageMap = {
  //     //   "message": mssgController.text,
  //     //   "sender": ,
  //     //   "time": DateTime.now().millisecondsSinceEpoch,
  //     // };

  //     DatabaseService().sendMessage( chatMessageMap);
  //     // DatabaseService().sendMassage(widget.id, chatMessageMap);
  //     setState(() {
  //        mssgController.clear();
  //     });
  //   }
  // }
}

 
