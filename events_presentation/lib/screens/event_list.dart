import 'package:events_presentation/data/EventProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/Event.dart';
import 'event_form.dart';
import 'event_item.dart';
import 'package:events_presentation/assets/constants.dart' as constants;

class EventList extends StatefulWidget {

  const EventList({required this.items});
  final List<Event>? items;

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {

  List<Event> eventos = [];

  @override
  void initState(){
    Provider.of<EventProvider>(context, listen: false).getEventsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 56,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(constants.listadoEventos,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
                ),
              ),
              Icon(Icons.filter_list_alt)
            ],
          ),
        ),
        const SizedBox(
          height: 10,
          width: 0,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: this.widget.items!.length,
          itemBuilder: (context, item){
            //return EventItem(item:  this.items![item]);
            return GestureDetector(
              child: EventItem(item:  this.widget.items![item]),
              onTap: () => {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventFormScreen(event: this.widget.items![item],isNew: false,)),
                ).then((value)=> initState())
              },
            );
          },
        )

      ],
    );
  }
}