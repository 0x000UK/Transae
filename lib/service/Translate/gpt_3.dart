import 'dart:convert';
import 'api_key.dart';
import 'package:http/http.dart' as http;

class Chat {

  //ChatGPt({required this.text, required this.initialLanguage, required this.desiredLanguage});

  // final String text;
  // final String initialLanguage;
  // final String desiredLanguage;

  static Future<dynamic> translateMessage(String text, String desiredLanguage) async {

    if(text.isNotEmpty) {
      return sendRequest(text, desiredLanguage);
    }
    else {
      return "Error";
    }
  }
  static Future<String> sendRequest( String text, String targetLanguage) async {
    const  String apiKey = APIKey.key;
    const  String apiUrl = 'https://api.openai.com/v1/completions';

    final response = await http.post(Uri.parse(apiUrl), 
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      }, 
      body: jsonEncode({
        'prompt': 'Translate the following text to $targetLanguage: "$text"',
        'max_tokens': 10,
        'model' : 'gpt-3.5-turbo-16k-0613'
      }
      )
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['text'].toString();
    } else {
      return "";
    }
  }
}
