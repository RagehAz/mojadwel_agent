import 'dart:convert';
import 'dart:io';
// import 'package:googleapis_auth/auth_io.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:mojadwel_agent/core/utilities/helpers.dart';

class GeminiService {

  GeminiService() {
    final jsonStr = File('service-account.json').readAsStringSync();
    _credentials = ServiceAccountCredentials.fromJson(jsonStr);
  }

  final String _scopes = 'https://www.googleapis.com/auth/cloud-platform';
  late ServiceAccountCredentials _credentials;
  late AutoRefreshingAuthClient _client;

  /// Initialize the client
  Future<void> init() async {

        
    // applicationDefault() will look for credentials in the following locations:
    // * the service-account.json file in the package main directory
    // * the env variable GOOGLE_APPLICATION_CREDENTIALS
    // * a configuration file, specific for this library, stored in the user's home directory
    // * gcloud's application default credentials
    // * credentials from the firebase tools
    const serviceAccountPath = r'E:\dev\projects\mojadwel\mojadwel_agent\service-account.json';
    blog('serviceAccountPath: $serviceAccountPath',);

    // var credential = Credentials.applicationDefault();

    blog('credential: $_credentials',);
    blog('Credentials.applicationDefault(): ${Credentials.applicationDefault()}',);

    // when no credentials found, login using openid
    // the credentials are stored on disk for later use
    // either set the parameters clientId and clientSecret of the login method or
    // set the env variable FIREBASE_CLIENT_ID and FIREBASE_CLIENT_SECRET
    // credential ??= await Credentials.login();

    const projectId = 'mojadwelagent';

    // create an app
    var app = FirebaseAdmin.instance.initializeApp(AppOptions(
        credential: Credentials.applicationDefault()!,
        projectId: projectId,
        storageBucket: '$projectId.appspot.com'));

    blog('app: $app',);

    // var app = FirebaseAdmin.instance.initializeApp(AppOptions(
    //   credential: ServiceAccountCredential('service-account.json'),
    //   projectId: 'mojadwelagent',
    //   storageBucket: 'mojadwelagent.firebasestorage.app',
    // ));

    // await Firebase.initializeApp(
    //   options: const FirebaseOptions(
    //     apiKey: 'AIzaSyC4pBl-XB9KVzIrwM2HWPiZX3Y2xEqZFvA',
    //     authDomain: 'mojadwelagent.firebaseapp.com',
    //     projectId: 'mojadwelagent',
    //     storageBucket: 'mojadwelagent.firebasestorage.app',
    //     messagingSenderId: '410652668976',
    //     appId: '1:410652668976:web:52772a762917a4eff4e9f5',
    //   ),
    // );

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
