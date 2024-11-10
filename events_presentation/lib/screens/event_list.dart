import 'package:flutter/material.dart';
import '../data/Event.dart';
import 'event_item.dart';
import 'package:events_presentation/assets/constants.dart' as constants;

class EventList extends StatelessWidget {

  EventList({required this.items});
  final List<Event>? items;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 56,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const[
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
          itemCount: this.items!.length,
          itemBuilder: (context, item){
            return EventItem(item:  this.items![item]);
          },
        )

      ],
    );
  }
}