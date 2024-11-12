import 'dart:convert';

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

  Future<Event> postEvent(Event event) async {
    var uri = Uri.parse(constants.urlServer);
    var response = await http.post(uri,
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode (event)
    );
    if(response.statusCode == 201){
      return Event.fromJson(json.decode(response.body));
    }else{
      throw(constants.errorAgregarEvento);
    }
  }

  Future<Event> putEvent(Event event) async {
    var uri = Uri.parse(constants.urlServer + "/"+event.id);
    var response = await http.put(uri,
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode (event)
    );
    if(response.statusCode == 200){
      return Event.fromJson(json.decode(response.body));
    }else{
      throw(constants.errorAgregarEvento);
    }
  }

  Future<Event> deleteEvent(String id) async {
    var uri = Uri.parse(constants.urlServer+"/"+id);
    var response = await http.delete(uri
    );
    if(response.statusCode == 200){
      return Event.fromJson(json.decode(response.body));
    }else{
      throw(constants.errorAgregarEvento);
    }
  }

}