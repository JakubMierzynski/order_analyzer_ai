import "dart:convert";
import "package:http/http.dart" as http;
import "package:rekrutacja_ai_native/config/app_config.dart";

Future<String> getLLMResponse(String userInput) async {
  final config = await AppConfig.load();

  const endpoint = "https://openrouter.ai/api/v1/chat/completions";

  final headers = {
    "Authorization": "Bearer ${config.apiKey}",
    "Content-Type": "application/json",
  };

  final body = {
    "model": "minimax/minimax-m2:free",
    'messages': [
      {'role': 'user', 'content': "Prompt"},
    ],
  };

  final response = await http.post(
    Uri.parse(endpoint),
    headers: headers,
    body: body,
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'];
  } else {
    throw Exception(
      "Failed to get response: ${response.body}",
    ); // dodać odpowiedź na podstawie statusCode.
  }
}
