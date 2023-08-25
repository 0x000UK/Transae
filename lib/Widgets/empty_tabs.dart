//import 'package:firebase_app/Models/UserModel.dart';
import 'package:flutter/material.dart';

Widget emptyTabContent({ required String tab, String? text}) {
  return Center(
        child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Container(
            width: 300,
            height: 280,
            alignment: Alignment.centerLeft,
            decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    tab == 'chats'? "assets/images/Worried-amico.png" :
                    tab == 'groups'? "assets/images/group.png":
                    "assets/images/group.png"
                  ),
                  fit: BoxFit.contain),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          text == null ? const Text.rich(
              TextSpan(text: 'OOPS!!', children: [
              TextSpan(text: '  Sorry',style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: " Can't see anyone ",style: TextStyle(fontSize: 20)),
              TextSpan(text: '\nMay be try adding someone'),
            ]),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ):
          Text(text),
        ],
      )
  );
}