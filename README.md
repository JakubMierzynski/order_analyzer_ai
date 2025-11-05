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


<img width="432" height="935" alt="Produkty" src="https://github.com/user-attachments/assets/97a3665e-ee72-44de-ac7e-4d58d2ca22f1" />
<img width="433" height="934" alt="Brak produktu" src="https://github.com/user-attachments/assets/2d1df14c-1b30-443a-9d35-1474cc333d0a" />
<img width="431" height="932" alt="Asystent zamówienia" src="https://github.com/user-attachments/assets/f2322b21-cf57-4f3d-bceb-64e93c813244" />
<img width="433" height="942" alt="Zamówienie" src="https://github.com/user-attachments/assets/e4bbd01f-f68c-45ad-946d-9d8d7ac2fd26" />
