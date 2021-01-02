import 'dart:convert';

import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:appkinsonFront/views/Notifications/NotificationPlugin.dart';
import 'package:flutter/material.dart';
import '../../model/User.dart';
import '../Relations/user_data.dart';
import 'Buttons/ButtonLinkPatient.dart';

class DoctorPatients extends StatefulWidget {
  @override
  DoctorPatientsCustom createState() => DoctorPatientsCustom();
}

class DoctorPatientsCustom extends State<DoctorPatients> {

  final TextEditingController addPatientController = new TextEditingController();
  final GlobalKey<FormState> _keyDialogForm = new GlobalKey<FormState>();
  List<User> patients = [];

  @override
  void initState() {
    super.initState();
    getPatients();
    addPatientController.text = 'Hello';
  }

  getPatients() async{
    var lista = token.split(".");
    var payload = lista[1];

    switch (payload.length % 4) {
      case 1:
        break; // this case can't be handled well, because 3 padding chars is illeagal.
      case 2:
        payload = payload + "==";
        break;
      case 3:
        payload = payload + "=";
        break;
    }

    var decoded = utf8.decode(base64.decode(payload));
    currentUser = json.decode(decoded);
    //Pedir lista de pacientes relacionados
    var patientsAux = await EndPoints().linkedUser(currentUser['id'].toString(), token);
    List<User> _patients = [];
    for(var a = 0; a < patientsAux.length; a++){
      User u = new User();
      u.email = patientsAux[a];
        _patients.add(u);
        debugPrint("------");
        debugPrint(u.email);
    }
    setState(() {
        patients = _patients;
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pacientes'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: (){},
            )
          ],
        ),
        body: Container(
            child: Column(
              children: <Widget>[
                /*Expanded(
                  child: PatientsList(patients),
                ),*/
                FlatButton(
                  shape:
                  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                  onPressed: () {
                    addUser();
                    debugPrint(addPatientController.text);
                  },
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Agregar Paciente", style: TextStyle(fontSize: 20)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: patients.length,
                  itemBuilder: (context, index){
                    User patient = patients[index];
                    return ListTile(
                        title : Text(patient.email),
                        //subtitle: Text(user.email),
                        leading: CircleAvatar(
                          child: Icon(Icons.account_circle_outlined),
                        )
                    );
                  },
                )
              ],
            )
          ),
        ),
    );
  }

  Future addUser() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Form(
              key: _keyDialogForm,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                    hintText: "Ingrese el email del paciente a agregar",
                    hintStyle: TextStyle(color: Colors.grey),
                    ),
                    textAlign: TextAlign.center,
                    onSaved: (val) {
                      addPatientController.text = val;
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  if (_keyDialogForm.currentState.validate()) {
                    _keyDialogForm.currentState.save();
                    debugPrint(addPatientController.text);
                    var lista = token.split(".");
                    var payload = lista[1];

                    switch (payload.length % 4) {
                      case 1:
                        break; // this case can't be handled well, because 3 padding chars is illeagal.
                      case 2:
                        payload = payload + "==";
                        break;
                      case 3:
                        payload = payload + "=";
                        break;
                    }

                    var decoded = utf8.decode(base64.decode(payload));
                    currentUser = json.decode(decoded);
                    debugPrint(currentUser['id'].toString());
                    var listaUsuarios = await EndPoints().linkUser(addPatientController.text, currentUser['id'].toString(), token);
                    debugPrint(listaUsuarios.toString());
                    //getPatients();
                    Navigator.pop(context);
                  }
                },
                child: Text('Agregar'),
                color: Colors.blue,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar')),
            ],
          );
        });
  }
}

class PatientsList extends StatelessWidget {

  List<User> _patients;

  PatientsList(this._patients);

  @override
  Widget build(BuildContext context) {
    return ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: _buildPatiensList(),
      );
  }

  List<PatientsListItem> _buildPatiensList(){
    return _patients.map((User) => PatientsListItem(User)).toList();
  }
}

class PatientsListItem extends ListTile{

  PatientsListItem(User user) :
      super(
        title : Text(user.email),
        //subtitle: Text(user.email),
        leading: CircleAvatar(
          child: Icon(Icons.account_circle_outlined),
        )
      );
}
