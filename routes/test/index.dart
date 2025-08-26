import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';

Future<Response> onRequest(RequestContext context) async {
  final env = context.read<DotEnv>();
  print(env['KEY']);
  return Response.json(body: {'message': "Hello World"});
}
