import 'package:dart_frog/dart_frog.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:googleapis_auth/auth_io.dart';
import 'package:mojadwel_agent/core/providers/config.dart';

Middleware calenderProvider() {
  return provider<Calender>((context) {
    final config = context.read<Config>();
    if (config.googleClientId == null || config.googleClientSecret == null) {
      throw Exception('Google client ID or secret is not set');
    }
    final clientId =
        ClientId(config.googleClientId!, config.googleClientSecret);
    return Calender(clientId);
  });
}

class Calender {
  Calender(this.clientId);

  final ClientId clientId;

  Future<void> createEvent() async {
    final authClient = await clientViaUserConsentManual(
      clientId,
      [
        calendar.CalendarApi.calendarScope,
        calendar.CalendarApi.calendarEventsScope
      ],
      (uri) async {
        print(uri);
        return uri;
      },
    );
    final calendarApi = calendar.CalendarApi(authClient);
    // test if the client is authenticated
    final calendars = await calendarApi.calendarList.list();
    print(calendars);
  }
}
