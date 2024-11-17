import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../data/Event.dart';
import '../data/EventProvider.dart';
import 'event_form.dart';
import 'event_list.dart';
import 'package:events_presentation/assets/constants.dart' as constants;

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen>  with WidgetsBindingObserver {
  @override
  void initState() {
    Provider.of<EventProvider>(context, listen: false).getEventsData();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.removeObserver(this);


    //Se comenta ya que se va a usar FutureBuilder
    /*
    _fetchQuote().then((value) {
      quote = value;
      setState(() {});
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffF5F8FC),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SingleChildScrollView(
                  child:
                      Consumer<EventProvider>(
                        builder: (context, value, child) {
                          if(value.events.isNotEmpty){
                            return EventList(
                              items: context.watch<EventProvider>().events,
                            );
                          }
                          return const Center(
                            child: Text("messageErrorCarsApi"),
                          );
                        },
                      ),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Event _event = Event(id: '',
              nombre: '', categoria: '', fecha: '',
              ciudad: '', lugar: '', detalle: '');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventFormScreen(event: _event,isNew: true))
          ).then((value)=> initState());
        },
        tooltip: constants.nuevo,
        child: const Icon(Icons.add),
      ),
    );
  }
}