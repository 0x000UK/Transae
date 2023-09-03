
import 'package:firebase_app/Widgets/colors.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  final String message;
  final String senderId;
  final String currentUser;

  const MessageBox(
    {Key? key,
      required this.message,
      required this.senderId,
      required this.currentUser
    }
  ) : super(key: key);

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {

  bool isSentByMe = false;
  @override
  Widget build(BuildContext context) {

    isSentByMe = widget.currentUser == widget.senderId;
    return Container(
      decoration:const BoxDecoration(
      // color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      padding: EdgeInsets.only(
        top: 4,
        bottom: 5,
        left: isSentByMe ? 0 : 5,
        right: isSentByMe ? 5 : 0
      ),
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: isSentByMe
            ? const EdgeInsets.only(left: 30)
            : const EdgeInsets.only(right: 30),
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: isSentByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
            color: isSentByMe
                ? const Color(0xF805111D)
                : LightThemeColors.darkgrey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.message,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
      ),
    );
  }
}