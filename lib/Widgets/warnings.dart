import 'package:flutter/material.dart';

void showWarning(BuildContext context, Object message){

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: const Color.fromARGB(205, 219, 30, 30),
    content: Text(
      message.toString(),
      textAlign: TextAlign.center,
    ),
    duration: const Duration(seconds: 4),
  ));
}