import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:mojadwel_agent/core/providers/config.dart';
import 'package:mojadwel_agent/core/utilities/rest.dart';

Middleware geminiProvider() {
  return provider<Gemini>((context) {
    final config = context.read<Config>();
    if (config.geminiApiKey == null) {
      throw Exception('Gemini API key is not set');
    }

    return Gemini(apiKey: config.geminiApiKey!);
  });
}

class Gemini {
  Gemini({required this.apiKey});
  final String apiKey;

  Future<String> generateText(String prompt) async {
    final response = await Rest.postMap(
      rawLink:
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent',
      headers: {
        'x-goog-api-key': apiKey,
        'Content-Type': 'application/json',
      },
      map: {
        'contents': [
          {
            'parts': [
              {'text': prompt},
            ],
          },
        ],
      },
    );

    Rest.blogResponse(response: response);
    final body = jsonDecode(response!.body);
    // ignore: avoid_dynamic_calls
    return body['candidates'][0]['content']['parts'][0]['text'] as String;
  }
}
