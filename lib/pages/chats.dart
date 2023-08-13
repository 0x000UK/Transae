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
 
    return Scaffold(
      backgroundColor:const  Color.fromARGB(255, 255, 151, 151),
        
      body: Column(
        children: [

          Container(
            decoration:const BoxDecoration(
              color:  Color.fromARGB(255, 255, 151, 151)
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
          Expanded(
            child: Padding(padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
              color:  Color.fromARGB(200, 255, 186, 186),
              ),
              child: Center(
                child: Text('This is your home page'), // body: SingleChildScrollView(...)
              ),
            ),
            )
          ),
          Container(
            color:const Color.fromARGB(255, 255, 151, 151),
            child: Row (
              children : [
                Container(
                  padding: EdgeInsets.only(left: 12),  
                  width: MediaQuery.of(context).size.width-80,
                  height: 75,
                  child :
                const TextField(
                decoration: InputDecoration(
                  contentPadding:  EdgeInsets.symmetric(vertical: 18.0, horizontal: 30.0),
                  hintText: 'Enter text....',
                  fillColor: Color.fromARGB(234, 165, 126, 126),
                  filled: true,
                  hintStyle:  TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(123, 0, 0, 0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(45.0)),
                  ),
                ),
              ),
                ),
                const SizedBox(width: 10),
                Padding(padding:const EdgeInsets.only(bottom: 20),
                child : IconButton(
                  onPressed: (){}, 
                  icon:const Icon(Icons.send), 
                  iconSize: 40,
                ),
                )
              ]
            )
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

 
