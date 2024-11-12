import 'package:events_presentation/data/Event.dart';
import 'package:flutter/cupertino.dart';
import 'EventHttpService.dart';

class EventProvider extends ChangeNotifier{
  List<Event> events = [];
  Event event=Event(id: "", nombre: "", categoria: "", fecha: "", ciudad: "",
      lugar: "", detalle: "");
  EventHttpService eventHttpService = EventHttpService();

  void getEventsData() async{
    events = await eventHttpService.getEvents();
    notifyListeners();
  }
 Future<Event> postEvent(Event _event) async{
    event = await eventHttpService.postEvent(_event);
    notifyListeners();
    return event;
  }
  Future<Event> putEvent(Event _event) async{
    event = await eventHttpService.putEvent(_event);
    notifyListeners();
    return event;
  }
  Future<Event> deleteEvent(String id) async{
    event = await eventHttpService.deleteEvent(id);
    notifyListeners();
    return event;
  }
}