import 'package:flutter/material.dart';
import 'package:firebase_app/widgets/message_tile.dart';
class ChatMessage{
  String messageContent;
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType});
}

class MyMessagesPage extends StatefulWidget {
  const MyMessagesPage({super.key, required this.id,  required this.name});

  final String id;
  final String name;
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
 
    return  Scaffold(
      backgroundColor: const Color.fromARGB(200, 255, 186, 186),
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 151, 151), // const Color.fromARGB(255, 255, 151, 151),
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back,color: Colors.black,),
                ),
                const SizedBox(width: 2,),
                Hero(
                  tag: 'profilepic${widget.id}',
                  child: const CircleAvatar(
                    radius: 28,
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
                      Text(widget.name, style: const TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      const SizedBox(height: 6,),
                      Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
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
        ),
        
      ),
      body: Stack(
        children: <Widget>[
          // chat messages here
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[700],
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                  controller: mssgController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Send a message...",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    border: InputBorder.none,
                  ),
                )),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.send,
                      color: Colors.white,
                    )),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
    chatMessages() {
    return StreamBuilder(
      //stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      message: snapshot.data.docs[index]['message'],
                      sender: snapshot.data.docs[index]['sender'],
                      sentByMe: widget.name ==
                          snapshot.data.docs[index]['sender']);
                },
              )
            : Container();
      },
    );
  }

   sendMessage() {
    if (mssgController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": mssgController.text,
        "sender": widget.name,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      // DatabaseService().sendMessage(widget.groupId, chatMessageMap);
      // setState(() {
      //   messageController.clear();
      // });
    }
  }
}

 
