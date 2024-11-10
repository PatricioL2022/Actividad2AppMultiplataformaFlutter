import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:events_presentation/assets/constants.dart' as constants;
import 'package:form_builder_validators/form_builder_validators.dart';

class EventFormScreen extends StatelessWidget {
  EventFormScreen({super.key});
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: AppBar(title: const Text(constants.formularioEvento)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'id',
                    decoration: const InputDecoration(labelText: constants.id),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: constants.idRequerido)
                    ]),
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'nombre',
                    decoration: const InputDecoration(labelText: constants.nombre),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: constants.nombreRequerido)
                    ]),
                  ),
                  const SizedBox(height: 10),
                  FormBuilderDropdown(
                    name: 'categoria',
                    decoration: const InputDecoration(labelText: constants.categoria),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: constants.categoriaRequerido)
                    ]),
                    items: ['Male', 'Female', 'Other']
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
                    initialDate: DateTime.now(),
                    initialValue: DateTime.now(),
                    firstDate: DateTime.now()
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'ciudad',
                    decoration: const InputDecoration(labelText: constants.ciudad),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: constants.ciudadRequerido)
                    ]),
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'lugar',
                    decoration: const InputDecoration(labelText: constants.lugar),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: constants.lugarRequerido)
                    ]),
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'detalle',
                    decoration: const InputDecoration(labelText: constants.detalle),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: constants.detalleRequerido)
                    ]),
                  ),


                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        print(_formKey.currentState!.value.entries.toList());
                      }
                    },
                    child: const Text(constants.guardar),
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