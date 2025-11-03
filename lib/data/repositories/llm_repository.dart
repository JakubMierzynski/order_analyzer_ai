import "dart:convert";

import "package:http/http.dart" as http;

Future<String> getLLMResponse(String userInput) async {
  const endpoint = "https://openrouter.ai/api/v1/chat/completions";

  final headers = {
    "Authorization": "Bearer <OPENROUTER_API_KEY>",
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
