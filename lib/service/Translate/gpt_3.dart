import 'dart:convert';
import 'api_key.dart';
import 'package:http/http.dart' as http;

class Chat {

  static Future<dynamic> sendMessage(String text, String? desiredLanguage) async {

    if(text.isNotEmpty) {
      return translate(text, desiredLanguage);
    }
    else {
      return "error";
    }
  }

  static Future<String> translate( String text, String? targetLanguage) async {
    const  String apiKey = APIKey.key;
    const  String apiUrl = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(Uri.parse(apiUrl), 
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      }, 
      body: jsonEncode({
        'prompt': targetLanguage == null? text : 'Translate the following text to $targetLanguage: $text',
        'model' : 'gpt-3.5-turbo'
      }
      )
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['text'].toString();
    } else {
      return "error";
    }
  }
}
