import 'package:flutter/material.dart';
import '../data/Event.dart';

class EventItem extends StatelessWidget {
  EventItem({required this.item});

  final Event item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 150,
      child: Card(
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Evento: ${item.nombre}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Lugar: ${item.ciudad} - ${item.lugar}"),
                    Text("Fecha: ${item.fecha} ${item.hora}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}