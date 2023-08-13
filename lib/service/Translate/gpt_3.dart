import 'dart:convert';
import 'api_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_app/pages/chats.dart';

class ChatGPt {

  ChatGPt({required this.controller, required this.initialLanguage, required this.desiredLanguage});

  final TextEditingController controller;
  final String initialLanguage;
  final String desiredLanguage;

  void onSendMessage() async {

    String message = controller.text.trim();

    if(message.isNotEmpty) {
      String translatedText = await translateMessage(initialLanguage, message, desiredLanguage);
    }
  }
  Future<String> translateMessage(String initialLang, String message, String targetLanguage) async {
    const  String apiKey = APIKey.key;
    const  String apiUrl = 'https://api.openai.com/v1/engines/davinci-codex/completions';
    
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    }, body: jsonEncode({
      'prompt': 'Translate the following $initialLang text to $targetLanguage: "$message"',
      'max_tokens': 500,
    }));
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['choices'][0]['text'];
    } else {
      throw Exception('Failed to translate message');
    }
  }
}
