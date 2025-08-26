import 'package:dart_frog/dart_frog.dart';
import 'package:mojadwel_agent/core/providers/gemini.dart';

Future<Response> onRequest(RequestContext context) async {
  final gemini = context.read<Gemini>();
  final response = await gemini.generateText('Hello, how are you?');
  return Response.json(body: {'message': response});
}
