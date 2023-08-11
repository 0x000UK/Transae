import 'package:flutter/material.dart';
 
class MyMessagesPage extends StatefulWidget {
  const MyMessagesPage({super.key, required this.index,  required this.name});

 final int index;
 final String name;
  @override
  State<MyMessagesPage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyMessagesPage> {

  @override
  Widget build(BuildContext context) {
 
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title:  Row(
          children: [
              Hero(
              tag: 'profilepic${widget.index}',
              child: const CircleAvatar(
                radius: 25,
                backgroundImage:NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
              ),
            ),
            const SizedBox(width: 20,),
            Text(widget.name)
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon:const Icon(Icons.search)),
          IconButton(onPressed: (){}, icon:const Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}