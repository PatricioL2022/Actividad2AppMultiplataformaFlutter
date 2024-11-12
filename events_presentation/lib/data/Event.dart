import 'dart:convert';
List<Event> eventsModelFromJson(String str) => List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventsModelToJson(List<Event> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
  final String id;
  final String nombre;
  final String categoria;
  final String fecha;
  final String ciudad;
  final String lugar;
  final String detalle;

  const Event({
    required this.id,
    required this.nombre,
    required this.categoria,
    required this.fecha,
    required this.ciudad,
    required this.lugar,
    required this.detalle,
  });

  Map<String, dynamic> toJson() => {
    "id": this.id,
    "nombre": this.nombre,
    "categoria": this.categoria,
    "fecha": this.fecha,
    "ciudad":this.ciudad,
    "lugar": this.lugar,
    "detalle": this.detalle
  };
  factory Event.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'id': String id,
      'nombre': String nombre,
      'categoria': String categoria,
      'fecha': String fecha,
      'ciudad': String ciudad,
      'lugar': String lugar,
      'detalle': String detalle
      } =>
          Event(
              id: id,
              nombre: nombre,
              categoria: categoria,
              fecha: fecha,
              ciudad: ciudad,
              lugar: lugar,
              detalle: detalle
          ),
      _ => throw const FormatException('Failed to load event.'),
    };
  }
}
