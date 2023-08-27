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
                    "assets/images/activity.png"
                  ),
                  fit: BoxFit.contain),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          text == null ? const Text ( "Feature under development",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ):
          Text(text),
        ],
      )
  );
}