import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';

Middleware configProvider() {
  final env = DotEnv(includePlatformEnvironment: true)..load();
  return provider<Config>((context) => Config(env));
}

class Config {
  Config(this._env);
  final DotEnv _env;

  String? get geminiApiKey => _env['GEMINI_API_KEY'];
}
