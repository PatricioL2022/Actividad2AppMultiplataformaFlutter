import 'package:events_presentation/data/Event.dart';
import 'package:flutter/cupertino.dart';
import 'EventHttpService.dart';

class EventProvider extends ChangeNotifier{
  List<Event> events = [];
  EventHttpService eventHttpService = EventHttpService();

  void getEventsData() async{
    events = await eventHttpService.getEvents();
    notifyListeners();
  }
}