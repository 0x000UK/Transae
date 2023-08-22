
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
      padding: EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: isSentByMe ? 0 : 15,
        right: isSentByMe ? 15 : 0
      ),
      alignment: isSentByMe ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Container(
        margin: isSentByMe
            ? const EdgeInsets.only(left: 30)
            : const EdgeInsets.only(right: 30),
        padding: const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
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
                ? ThemeColors.redorange
                : ThemeColors.darkgrey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   widget.senderId.toUpperCase(),
            //   textAlign: TextAlign.start,
            //   style: const TextStyle(
            //       fontSize: 13,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white,
            //       letterSpacing: -0.5),
            // ),
            // const SizedBox(
            //   height: 8,
            // ),
            Text(widget.message,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 16, color: Colors.white))
          ],
        ),
      ),
    );
  }
}