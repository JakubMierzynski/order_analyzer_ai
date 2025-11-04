import "dart:convert";
import "package:http/http.dart" as http;
import "package:rekrutacja_ai_native/config/app_config.dart";

class LLMException implements Exception {
  final String message;
  LLMException(this.message);

  @override
  String toString() => message;
}

class InvalidApiKeyException implements Exception {
  final String message;
  InvalidApiKeyException([this.message = "Nieprawidłowy klucz API"]);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  @override
  String toString() => "Brak połączenia z internetem.";
}

class LLMRepository {
  Future<String> getLLMResponse(String userInput) async {
    final config = await AppConfig.load();
    final apiKey = config.apiKey;

    if (apiKey.isEmpty) {
      throw InvalidApiKeyException("Brak klucza api");
    }

    const endpoint = "https://openrouter.ai/api/v1/chat/completions";

    final headers = {
      "Authorization": "Bearer $apiKey",
      "Content-Type": "application/json",
    };

    final body = jsonEncode({
      "model": "minimax/minimax-m2:free",
      'messages': [
        {'role': 'user', 'content': userInput},
      ],
    });

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        throw InvalidApiKeyException();
      } else {
        throw LLMException("Błąd AI: ${response.statusCode}");
      }
    } catch (e) {
      if (e is LLMException || e is InvalidApiKeyException) rethrow;
      throw NetworkException();
    }
  }
}
