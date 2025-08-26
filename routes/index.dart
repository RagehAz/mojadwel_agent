import 'package:dart_frog/dart_frog.dart';
import 'package:mojadwel_agent/core/utilities/web_interface_html.dart';

// Response onRequest(RequestContext context) {
//   return Response(body: 'Welcome to Dart Frog!');
// }

Future<Response> onRequest(RequestContext context) async {
  // POST request handler
  if (context.request.method == HttpMethod.post) {
    final bodyString = await context.request.body();
    print('Received message: $bodyString');

    return Response.json(
      body: {'status': 'ok', 'received': bodyString},
    );
  }

  // GET request → return the web interface
  return Response(
    body: webInterfaceHtml(),
    headers: {'Content-Type': 'text/html'},
  );
}
