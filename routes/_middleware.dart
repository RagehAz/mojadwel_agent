import 'package:dart_frog/dart_frog.dart';
import 'package:mojadwel_agent/core/providers/config.dart';
import 'package:mojadwel_agent/core/providers/gemini.dart';

Handler middleware(Handler handler) {
  return (context) async {
    return handler.use(geminiProvider()).use(configProvider()).call(context);
  };
}
