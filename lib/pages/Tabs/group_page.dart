import 'package:flutter/material.dart';
import 'package:firebase_app/Models/UserModel.dart';
 
class MyGroupTabPage extends StatefulWidget {
  const MyGroupTabPage({super.key, required this.userModel});
 
  final UserModel userModel;
 
  @override
  State<MyGroupTabPage> createState() => _MyGroupPageTab();
}
class _MyGroupPageTab extends State<MyGroupTabPage> {
 
  @override
  Widget build(BuildContext context) {
 
    return SliverToBoxAdapter(child: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Container(
              width: 400,
              height: 250,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/group.png"),
                    fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 20),
            const Text.rich(
              TextSpan(text: 'OOPS!!', children: [
                TextSpan(text: '  Sorry', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan( text: " Can't see anyone ", style: TextStyle(fontSize: 20)),
                TextSpan(text: '\nMay be Try joining any group'),
              ]),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        )
    ));
  }
}