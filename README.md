Konfiguracja AI (OpenRouter)

Kod pisany i testowany na symulatorze Iphone 16 pro max. Aplikacja nie jest dostosowana do innych rozmiarów ekranu. 

Aplikacja wykorzystuje OpenRouter API, które umożliwia komunikację z modelem językowym (LLM) do analizy zamówień użytkownika.

1. W folderze lib/config/ utwórz plik o nazwie: app_config.json
2. wklej do niego poniższy kod: 

{
  "openrouter_api_key": "YOUR_API_KEY_HERE"
}

Wygląd pliku app_config.json powinien wtedy odpowiadać app_config.example.json

3. Pobierz klucz API OpenRouter
	- Wejdź na stronę https://openrouter.ai
	- Zaloguj się lub utwórz konto.
	- Otwórz stronę API Keys:
        https://openrouter.ai/keys
	-	Wygeneruj nowy klucz i skopiuj go.
	-	Wklej klucz do pliku lib/config/app_config.json.
    - Zapisz zmiany w pliku app_config.json

Od tego momentu asystent AI będzie mógł:
	- odbierać i analizować zamówienia użytkownika
	- porównywać je z listą dostępnych produktów
	- zwracać podsumowanie zamówienia lub komunikat o błędzie.
	- zwracać zamówienie domyślnie w postaci JSON.


<img width="431" height="932" alt="Zrzut ekranu 2025-11-5 o 10 45 49" src="https://github.com/user-attachments/assets/47a6ee31-b278-488c-b87a-6e17238a76c9" />
<img width="433" height="934" alt="Zrzut ekranu 2025-11-5 o 10 45 40" src="https://github.com/user-attachments/assets/890a855a-cd87-4f1a-8e4d-63a76a2ee080" />
<img width="432" height="935" alt="Zrzut ekranu 2025-11-5 o 10 44 54" src="https://github.com/user-attachments/assets/c2584460-0656-4088-9776-b980298f86f3" />
<img width="433" height="942" alt="Zrzut ekranu 2025-11-5 o 10 44 24" src="https://github.com/user-attachments/assets/de32f4a5-8f1f-4633-8050-6d4325b98f06" />
