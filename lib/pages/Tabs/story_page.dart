import 'package:firebase_app/Widgets/empty_tabs.dart';
import 'package:flutter/material.dart';
 
 
class MyStoryPage extends StatefulWidget {
  const MyStoryPage({super.key});
 
 
  @override
  State<MyStoryPage> createState() => _MyStoryPageState();
}
class _MyStoryPageState extends State<MyStoryPage> {
 
  @override
  Widget build(BuildContext context) {
 
   return SliverToBoxAdapter(
    child: emptyTabContent(tab: "story")
    // Center(
    //     child: Column(
    //       children: [
    //         const SizedBox(height: 100),
    //         Container(
    //           width: 400,
    //           height: 250,
    //           alignment: Alignment.centerLeft,
    //           decoration: const BoxDecoration(
    //             image: DecorationImage(
    //                 image: AssetImage("assets/images/activity.png"),
    //                 fit: BoxFit.contain),
    //           ),
    //         ),
    //         const SizedBox(height: 20),
    //         const Text.rich(
    //           TextSpan(text: 'OOPS!!', children: [
    //             TextSpan(text: '  Sorry', style: TextStyle(fontWeight: FontWeight.bold)),
    //             TextSpan( text: " Can't see anyone ", style: TextStyle(fontSize: 20)),
    //             TextSpan(text: '\nMay be Try joining any group'),
    //           ]),
    //           style: TextStyle(color: Colors.white, fontSize: 20),
    //         ),
    //       ],
    //     )
    //   )
    );
  }
}