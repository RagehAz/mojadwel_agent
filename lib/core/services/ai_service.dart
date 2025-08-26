import 'dart:convert';
import 'dart:io';
import 'package:googleapis_auth/auth_io.dart';
import 'package:mojadwel_agent/core/utilities/helpers.dart';

class GeminiService {
  GeminiService(String serviceAccountPath) {
    final jsonStr = File(serviceAccountPath).readAsStringSync();
    _credentials = ServiceAccountCredentials.fromJson(jsonStr);
  }

  final String _scopes = 'https://www.googleapis.com/auth/cloud-platform';
  late ServiceAccountCredentials _credentials;
  late AutoRefreshingAuthClient _client;

  /// Initialize the client
  Future<void> init() async {
    blog('GeminiService started', invoker: 'GeminiService.init');
    _client = await clientViaServiceAccount(_credentials, [_scopes]);
    blog('Credentials: $_credentials', invoker: 'GeminiService.init');
    blog('Client: $_client', invoker: 'GeminiService.init');
    blog('_scopes:$_scopes', invoker: 'GeminiService.init');
  }

  /// Send a prompt to Gemini AI and get response
  Future<String> sendMessage(String prompt) async {
    // Correct project-based URL
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1/projects/mojadwelagent/locations/us-central1/models/text-bison-001:generate',
    );

    blog('Sending prompt: $prompt', invoker: 'GeminiService.sendMessage');

    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: jsonEncode({
        'prompt': {'text': prompt},
        'temperature': 0.7,
        'candidateCount': 1,
        'maxOutputTokens': 256,
      }),
    );

    blog('Gemini response status: ${response.statusCode}', invoker: 'GeminiService.sendMessage');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final outputText = data['candidates']?[0]?['output']?.toString() ?? '';
      blog('Gemini output: $outputText', invoker: 'GeminiService.sendMessage');
      return outputText;
    } else {
      blog('Gemini API Error: ${response.statusCode} ${response.body}', invoker: 'GeminiService.sendMessage');
      throw Exception('Gemini API Error: ${response.statusCode} ${response.body}');
    }
  }

}
