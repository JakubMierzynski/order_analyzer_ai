import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class AppConfig {
  final String apiKey;

  AppConfig({
    required this.apiKey,
  });

  static Future<AppConfig> load() async {
    final jsonString = await rootBundle.loadString('lib/config/app_config.json');
    final data = jsonDecode(jsonString);

    return AppConfig(
      apiKey: data['openrouter_api_key'],
    );
  }
}