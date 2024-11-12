import 'package:events_presentation/data/Event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:events_presentation/assets/constants.dart' as constants;
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import '../data/EventProvider.dart';
import 'package:intl/intl.dart';

class EventFormScreen extends StatelessWidget {
  EventFormScreen({super.key,required this.event,required this.isNew});
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late Event evento;
  final Event event;
  final bool isNew;
  late String titulo;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  void showSnack(String title) {
    final snackbar = SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
          ),
        ));
    scaffoldMessengerKey.currentState!.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    DateFormat format = new DateFormat("MM/dd/yyyy hh:mm");
    DateTime dateTime;
    if(!this.isNew){
      dateTime = format.parse(this.event.fecha);
      titulo = constants.editarEvento;
    }
    else {
      titulo = constants.agregarEvento;
      dateTime = DateTime.now();
    }
      var idController = TextEditingController(text: this.isNew ? "": this.event.id);
      var nombreController = TextEditingController(text: this.isNew ? "": this.event.nombre);
      var ciudadController = TextEditingController(text: this.isNew ? "": this.event.ciudad);
      var lugarController = TextEditingController(text: this.isNew ? "": this.event.lugar);
      var detalleController = TextEditingController(text: this.isNew ? "": this.event.detalle);

      addEvent(Event event) async {
        var provider = Provider.of<EventProvider>(context, listen: false);
        evento = await provider.postEvent(event);
        showSnack(constants.agregadoCorrectamente);
      }
      updateEvent(Event event) async {
        var provider = Provider.of<EventProvider>(context, listen: false);
        evento = await provider.putEvent(event);
        showSnack(constants.actualizadoCorrectamente);
      }
      deleteEvent(String id) async {
        var provider = Provider.of<EventProvider>(context, listen: false);
        evento = await provider.deleteEvent(id);
        showSnack(constants.borradoCorrectamente);
      }

      return ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
            resizeToAvoidBottomInset : false,
            appBar: AppBar(title: Text(titulo)),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'id',
                        controller: idController,
                        decoration: const InputDecoration(labelText: constants.id),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: constants.idRequerido)
                        ]),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'nombre',
                        controller: nombreController,
                        decoration: const InputDecoration(labelText: constants.nombre),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: constants.nombreRequerido)
                        ]),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderDropdown(
                        name: 'categoria',
                        initialValue: 'Concierto',
                        decoration: const InputDecoration(labelText: constants.categoria),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: constants.categoriaRequerido)
                        ]),
                        items: ['Concierto', 'Encuentro Cultural', 'Feria de Libro']
                            .map(
                              (gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ),
                        )
                            .toList(),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderDateTimePicker(
                          name: 'fecha',
                          decoration: const InputDecoration(labelText: constants.fecha),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: constants.fechaRequerido)
                          ]),
                          inputType: InputType.both,

                          initialDate: dateTime,
                          initialValue: dateTime,
                          firstDate: dateTime
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'ciudad',
                        controller: ciudadController,
                        decoration: const InputDecoration(labelText: constants.ciudad),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: constants.ciudadRequerido)
                        ]),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'lugar',
                        controller: lugarController,
                        decoration: const InputDecoration(labelText: constants.lugar),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: constants.lugarRequerido)
                        ]),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'detalle',
                        controller: detalleController,
                        decoration: const InputDecoration(labelText: constants.detalle),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: constants.detalleRequerido)
                        ]),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child:  ElevatedButton.icon(
                                  onPressed: this.isNew ? null: () async {
                                    if (await confirm(context,
                                        title: const Text(constants.confirmacion),
                                        content: const Text(constants.seguroEliminarEvento),
                                        textCancel: const Text(constants.no),
                                        textOK: const Text(constants.si)
                                    )) {
                                      if (_formKey.currentState!.saveAndValidate()) {
                                        var data = _formKey.currentState!.value.entries.toList();
                                        deleteEvent(data[0].value.toString());
                                        idController.clear();
                                        nombreController.clear();
                                        ciudadController.clear();
                                        lugarController.clear();
                                        detalleController.clear();

                                      }
                                    }
                                    return print('pressedCancel');
                                  },
                                  /**onPressed: this.isNew ? null: ()  {
                                    if (_formKey.currentState!.saveAndValidate()) {
                                      var data = _formKey.currentState!.value.entries.toList();
                                      deleteEvent(data[0].value.toString());
                                      idController.clear();
                                      nombreController.clear();
                                      ciudadController.clear();
                                      lugarController.clear();
                                      detalleController.clear();
                                    }
                                  },*/
                                  icon: Icon(Icons.delete_forever),  //icon data for elevated button
                                  label: Text(constants.eliminar), //label text
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                  )
                              )
                          ),
                          Expanded(
                            child:  ElevatedButton.icon(
                                onPressed: () {
                                  if (_formKey.currentState!.saveAndValidate()) {
                                    var data = _formKey.currentState!.value.entries.toList();
                                    Event event = Event(
                                        id: data[0].value.toString(),
                                        nombre: data[1].value.toString(),
                                        categoria: data[2].value.toString(),
                                        fecha: data[3].value.toString(),
                                        ciudad: data[4].value.toString(),
                                        lugar: data[5].value.toString(),
                                        detalle: data[6].value.toString());

                                    if(!this.isNew){
                                      updateEvent(event);
                                    }
                                    else{
                                      addEvent(event);
                                      idController.clear();
                                      nombreController.clear();
                                      ciudadController.clear();
                                      lugarController.clear();
                                      detalleController.clear();
                                    }
                                  }
                                },
                                icon: Icon(Icons.save),  //icon data for elevated button
                                label: Text(constants.guardar), //label text
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                )
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            )
        ),
      );
    }
  }
