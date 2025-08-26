import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';

Middleware configProvider() {
  final env = DotEnv(includePlatformEnvironment: true)..load();
  return provider<DotEnv>((context) => env);
}
