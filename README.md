Konfiguracja AI (OpenRouter)

Aplikacja wykorzystuje OpenRouter API, które umożliwia komunikację z modelem językowym (LLM) do analizy zamówień użytkownika.

1. W folderze lib/config/ utwórz plik o nazwie: app_config.json
2. wklej do niego swój klucz API: 

{
  "openrouter_api_key": "TWOJ_KLUCZ_API"
}

Jego wygląd powinien wtedy odpowiadać app_config.example.json

3. Pobierz klucz API OpenRouter
	- Wejdź na stronę https://openrouter.ai
	- Zaloguj się lub utwórz konto.
	- Otwórz stronę API Keys:
        https://openrouter.ai/keys
	-	Wygeneruj nowy klucz i skopiuj go.
	-	Wklej klucz do pliku lib/config/app_config.json.
    - Zapisz zmiany w pliku app_config.json

Od tego momentu asystent AI będzie mógł:
	•	odbierać i analizować zamówienia użytkownika
	•	porównywać je z listą dostępnych produktów
	•	zwracać podsumowanie zamówienia lub komunikat o błędzie