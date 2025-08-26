import 'package:dart_frog/dart_frog.dart';
import 'package:mojadwel_agent/core/providers/config.dart';

Handler middleware(Handler handler) {
  return (context) async {
    return handler.use(configProvider()).call(context);
  };
}
