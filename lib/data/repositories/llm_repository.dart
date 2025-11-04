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
        {'role': 'system', 'content': systemPrompt},
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

const String systemPrompt = """
Jesteś inteligentnym asystentem analizującym zamówienia klientów.

Twoje zadanie:
1. Otrzymujesz dwie informacje:
   - **listę produktów** z API (nazwa, cena, ID itp.),
   - **tekstowe zamówienie użytkownika** (np. "2x jabłko, 1 woda mineralna").
2. Na podstawie listy produktów **dopasuj pozycje** z zamówienia do produktów.
3. **Oblicz dla każdej pozycji:**
   - nazwę produktu (`productName`)
   - ilość (`quantity`)
   - cenę jednostkową (`unitPrice`)
   - sumę (`totalPrice = quantity * unitPrice`)
4. Na końcu podaj **łączną sumę** całego zamówienia (`grandTotal`).
5. Jeśli jakaś pozycja nie pasuje do żadnego produktu — dodaj ją z `status: "Niedopasowanie"` i `unitPrice: null`, `totalPrice: null`.

📤 Zwróć wynik **tylko w formacie JSON** w poniższej strukturze:
```json
{
  "order": [
    {
      "productName": "Jabłko",
      "quantity": 2,
      "unitPrice": 1.5,
      "totalPrice": 3.0,
      "status": "OK"
    },
    {
      "productName": "Woda mineralna",
      "quantity": 1,
      "unitPrice": 2.0,
      "totalPrice": 2.0,
      "status": "OK"
    },
    {
      "productName": "Chleb żytni",
      "quantity": 1,
      "unitPrice": null,
      "totalPrice": null,
      "status": "Niedopasowanie"
    }
  ],
  "grandTotal": 5.0
}

""";
