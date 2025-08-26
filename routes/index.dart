import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:mojadwel_agent/core/services/ai_service.dart';
import 'package:mojadwel_agent/core/utilities/helpers.dart';
import 'package:mojadwel_agent/core/utilities/web_interface_html.dart';

final gemini = GeminiService('secret_keys/mojadwelagent-firebase-adminsdk-fbsvc-1842af225f.json');

Future<Response> onRequest(RequestContext context) async {
  // Initialize Gemini once (hot reload will keep it)
  await gemini.init();

  if (context.request.method == HttpMethod.post) {
    final body = await context.request.body();
    final message = jsonDecode(body)['message'] as String?;

    blog('Received message: $message', invoker: 'onRequest');

    if (message != null) {
      try {
        final aiResponse = await gemini.sendMessage(message);
        blog('AI response: $aiResponse', invoker: 'onRequest');

        return Response.json(
          body: {'response': aiResponse},
        );
      } catch (e) {
        blog('AI call failed: $e', invoker: 'onRequest');

        return Response.json(
          body: {'error': 'Failed to generate response: $e'},
          statusCode: 500,
        );
      }
    } else {
      blog('No message provided', invoker: 'onRequest');
      return Response.json(
        body: {'error': 'No message provided'},
        statusCode: 400,
      );
    }
  }

  return Response(
    body: webInterfaceHtml(),
    headers: {'Content-Type': 'text/html'},
  );
}
