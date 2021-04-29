// home_material.dart
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/Register/InputFieldRegister.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemToolbox {
  int idItem;
  String titulo;
  String descripcion;
  String enlace;
  String type;
  ItemToolbox(
      {this.idItem, this.titulo, this.descripcion, this.enlace, this.type});
}

class FormItemToolboxPage extends StatefulWidget {
  @override
  _FormItemToolboxPageState createState() => _FormItemToolboxPageState();
}

TextEditingController titleController = new TextEditingController();
TextEditingController descripController = new TextEditingController();
TextEditingController linkController = new TextEditingController();

class _FormItemToolboxPageState extends State {
  @override
  void initState() {
    super.initState();
  }

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
            child: SingleChildScrollView(
                child: Builder(
                    builder: (context) => Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: titleController,
                                decoration: new InputDecoration(
                                    labelText: "Título",
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor ingrese un título';
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: linkController,
                                decoration: new InputDecoration(
                                    labelText: "Enlace",
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor ingrese el enlace del ítem';
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: descripController,
                                decoration: new InputDecoration(
                                    labelText: "Descripción",
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor ingrese una breve descripción';
                                  }
                                },
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 50, 0, 20),
                                child: Text(
                                  'Tipo de Ítem a Agregar: ',
                                ),
                              ),
                              DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                isExpanded: true,
                                style: const TextStyle(color: Colors.blue),
                                underline: Container(
                                  height: 2,
                                  color: Colors.blue[500],
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: <String>[
                                  'EJERCICIO',
                                  'NOTICIA',
                                  'ALIMENTACION'
                                ].map<DropdownMenuItem<String>>((String value) {
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
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0)),
                                      onPressed: () async {
                                        if (await canLaunch(
                                            linkController.text)) {
                                          debugPrint(titleController.text);
                                          debugPrint("");
                                          debugPrint(descripController.text);
                                          debugPrint("");
                                          debugPrint(linkController.text);
                                          debugPrint(dropdownValue);
                                          String token =
                                              await Utils().getToken();
                                          EndPoints().sendItemToolbox(
                                              titleController.text.toString(),
                                              descripController.text.toString(),
                                              linkController.text.toString(),
                                              dropdownValue,
                                              token);
                                          cleanData();
                                          Navigator.pop(context);
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                _buildPopupDialog(context),
                                          );
                                        }
                                      },
                                      color: Colors.blue,
                                      textColor: Colors.white,
                                      child: Text('Guardar'))),
                            ]))))));
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Agregando ítem')));
  }
}

cleanData() {
  titleController = new TextEditingController();
  descripController = new TextEditingController();
  linkController = new TextEditingController();
}

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: Text("Enlace invalido"),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Cancelar'),
      ),
    ],
  );
}
