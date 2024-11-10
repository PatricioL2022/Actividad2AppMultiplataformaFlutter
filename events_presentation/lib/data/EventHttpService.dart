import 'package:http/http.dart' as http;
import 'Event.dart';
import 'package:events_presentation/assets/constants.dart' as constants;

class EventHttpService {
  Future<List<Event>> getEvents() async {
    var uri = Uri.parse(constants.urlServer);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      // Si el servidor devolvió una respuesta 200 OK,
      return eventsModelFromJson(response.body);
    } else {
      // Si el servidor no devolvió una respuesta 200 OK,
      // entonces se lanza una excepción.
      throw(constants.mensajeErrorApi);
    }
  }
}