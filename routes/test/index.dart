import 'package:dart_frog/dart_frog.dart';
import 'package:mojadwel_agent/core/providers/calender.dart';

Future<Response> onRequest(RequestContext context) async {
  final calender = context.read<Calender>();
  await calender.createEvent();
  return Response.json(body: {'message': 'Event created'});
}
