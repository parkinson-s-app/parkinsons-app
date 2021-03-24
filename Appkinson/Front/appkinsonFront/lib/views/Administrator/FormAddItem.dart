// home_material.dart
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:flutter/material.dart';

class ItemToolbox {
  String titulo;
  String descripcion;
  String enlace;
  String type;
  ItemToolbox({this.titulo,this.descripcion,this.enlace, this.type});
}

class FormItemToolboxPage extends StatefulWidget {
  @override
  _FormItemToolboxPageState createState() => _FormItemToolboxPageState();
}

class _FormItemToolboxPageState extends State {
  final _formKey = GlobalKey();
  final _ItemToolbox = ItemToolbox();
  String dropdownValue = 'EJERCICIO';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Agregar ítem')),
        body: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration:
                            InputDecoration(labelText: 'Título'),
                            validator: (value) {

                              if (value.isEmpty) {
                                return 'Por favor ingrese un título';
                              }
                            },
                            onSaved: (val) =>
                                setState(() => _ItemToolbox.titulo = val),
                          ),
                          TextFormField(
                              decoration:
                              InputDecoration(labelText: 'Descripción'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Por favor ingrese una breve descripción';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _ItemToolbox.descripcion = val)),
                          TextFormField(
                              decoration:
                              InputDecoration(labelText: 'Enlace'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Por favor ingrese el enlace del ítem';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _ItemToolbox.enlace = val)),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                            child: Text('Tipo de ítem a agregar'),
                          ),
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>['EJERCICIO', 'NOTICIA', 'COMIDA']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),

                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: RaisedButton(
                                  onPressed: () {
                                    EndPoints().sendItemToolbox("Titulo prueba", "Descripción prueba", "Enlace prueba", "NOTICIA", token);
                                  },
                                  child: Text('Guardar'))),
                        ])))));
  }  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Agregando ítem')));
  }
}