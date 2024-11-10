import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/EventProvider.dart';
import 'event_list.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    Provider.of<EventProvider>(context, listen: false).getEventsData();
    super.initState();


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
    );
  }
}