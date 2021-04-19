// home_material.dart
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/Register/InputFieldRegister.dart';
import 'package:flutter/material.dart';

class ItemToolbox {
  int idItem;
  String titulo;
  String descripcion;
  String enlace;
  String type;
  ItemToolbox({this.idItem, this.titulo,this.descripcion,this.enlace, this.type});
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
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: SingleChildScrollView(
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: titleController,
                            decoration: InputDecoration(labelText: 'Título'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor ingrese un título';
                              }
                            },
                          ),
                          TextFormField(
                            controller: linkController,
                              decoration:
                              InputDecoration(labelText: 'Enlace'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Por favor ingrese el enlace del ítem';
                                }
                              },),
                          TextFormField(
                            controller: descripController,
                            decoration: InputDecoration(labelText: 'Descripción'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor ingrese una breve descripción';
                              }
                            },
                          ),
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
                                  onPressed: () async{
                                    debugPrint(titleController.text);
                                    debugPrint("");
                                    debugPrint(descripController.text);
                                    debugPrint("");
                                    debugPrint(linkController.text);
                                    debugPrint(dropdownValue);
                                    String token = await Utils().getToken();
                                    EndPoints().sendItemToolbox(titleController.text.toString(), descripController.text.toString(), linkController.text.toString(), dropdownValue, token);
                                    cleanData();
                                    Navigator.pop(context);
                                  },
                                  child: Text('Guardar'))),
                        ]))))));
  }  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Agregando ítem')));
  }
}

cleanData(){
  titleController = new TextEditingController();
  descripController = new TextEditingController();
  linkController = new TextEditingController();
}