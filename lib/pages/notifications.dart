import 'package:firebase_app/Widgets/empty_tabs.dart';
import 'package:flutter/material.dart';
 
class MyNotifications extends StatefulWidget {
  const MyNotifications({super.key});
 
 
  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}
class _MyNotificationsState extends State<MyNotifications> {
 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        height: size.height,
        child: Column(
          children: [
            SafeArea(
              child: SizedBox(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 30,),
                    Text(
                      'Notifiactions',
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  ],
                )
              ),
            ),
            Expanded(
              child: Padding(
                padding:const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: const BorderRadius.all(Radius.circular(30))

                  ),
                  child: ClipRRect(
                    child:Padding(
                      padding:const EdgeInsets.only(top: 30, left: 20, bottom: 30),
                      child : emptyTabContent(tab: "chats")
                  )
                )
              )
              )
            )
          ],
        ),
      )
    );
  }
}