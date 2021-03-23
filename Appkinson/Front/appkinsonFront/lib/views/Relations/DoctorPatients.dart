import 'dart:convert';

import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
//import 'package:appkinsonFront/views/Calendar/CalendarScreenView2.dart';
import 'package:appkinsonFront/views/Calendar/CalendarScreenView2Doctor.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:flutter/material.dart';
import '../../model/User.dart';

class DoctorPatients extends StatefulWidget {
  @override
  DoctorPatientsCustom createState() => DoctorPatientsCustom();
}

var codeListPatients;

class DoctorPatientsCustom extends State<DoctorPatients> {
  final TextEditingController addPatientController =
      new TextEditingController();
  final GlobalKey<FormState> _keyDialogForm = new GlobalKey<FormState>();
  List<User> patients = [];

  @override
  void initState() {
    super.initState();
    getPatients();
    addPatientController.text = 'Hello';
  }

  getPatients() async {
    /*
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
    */
    List<User> _patients = [];
    User patient;
    //Pedir lista de pacientes relacionados
    debugPrint("pidiendo pacientes");
    var patientsAux = await EndPoints().linkedUser(
        currentUser['id'].toString(), token, currentUser['type'].toString());
    debugPrint("pacientes pedidos");
    codeListPatients = json.decode(patientsAux);
    //List<User> patients = [];
    for (var a = 0; a < codeListPatients.length; a++) {
      //patients.add(codeList[a]['EMAIL']);
      patient = new User();
      patient.email = codeListPatients[a]['EMAIL'];
      patient.id = codeListPatients[a]['ID_USER'];
      _patients.add(patient);
    }
    /*
    for (var a = 0; a < patientsAux.length; a++) {
      User u = new User();
      u.email = patientsAux[a]['ID_USER'];
      _patients.add(u);
      debugPrint("------");
      debugPrint(u.email);
    }
    */
    /*User usuarioAux;
    usuarioAux.name = "Usuario Auxiliar";
    usuarioAux.email ="h@h.com";
    _patients.add(usuarioAux);*/
    setState(() {
      patients = _patients;
    });
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
              onPressed: () {},
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
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
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
              itemBuilder: (context, index) {
                User patient = patients[index];
                return ListTile(
                    onTap: () async {
                      String selectId;
                      meetingsDoctor = <Meeting>[];
                      //SymptomsFormPatientM m= await EndPoints().getSymptomsFormPatient(token,currentUser['id'].toString());\
                      selectId = patient.id.toString();
                      /* for (var a = 0; a < codeListPatients.length; a++) {
                        //patients.add(codeList[a]['EMAIL']);

                        if (codeListPatients[a]['EMAIL'] == patient.email) {
                          selectId = codeListPatients[a]['ID_USER'].toString();
                        }
                      } */
                      String m = await EndPoints()
                          .getSymptomsFormPatient(token, selectId);
                      //final DateTime today = DateTime.now();
                      listPacientes = m;

                      var codeList = json.decode(m);
                      //List<String> patients = [];
                      for (var a = 0; a < codeList.length; a++) {
                        //patients.add(codeList[a]['EMAIL']);
                        DateTime dateBd =
                            DateTime.parse(codeList[a]['formdate']);
                        final DateTime startTime = DateTime(dateBd.year,
                            dateBd.month, dateBd.day, dateBd.hour, 0, 0);
                        final DateTime endTime =
                            startTime.add(const Duration(hours: 1));
                        if (codeList[a]['Q1'] == 'on') {
                          meetingsDoctor.add(Meeting(
                              'on', startTime, endTime, Colors.green, false));
                        }
                        if (codeList[a]['Q1'] == 'off') {
                          meetingsDoctor.add(Meeting(
                              'off', startTime, endTime, Colors.red, false));
                        }
                        if (codeList[a]['Q1'] == 'on bueno') {
                          meetingsDoctor.add(Meeting('on bueno', startTime,
                              endTime, Colors.green[700], false));
                        }
                        if (codeList[a]['Q1'] == 'off malo') {
                          meetingsDoctor.add(Meeting('off malo', startTime,
                              endTime, Colors.red[800], false));
                        }
                      }

                      // RoutesPatient().toCalendar(context);
                      print(patients[index]);
                      //RoutesDoctor().toPatientAlarmAndMedicine(context, patient.id);
                      print('patient list ${patient.id.toString()}');
                      RoutesDoctor()
                          .toInteractionDoctorPatient(context, patient.id);
                    },
                    title: Text(patient.email),
                    //subtitle: Text(user.email),
                    leading: CircleAvatar(
                      child: Icon(Icons.account_circle_outlined),
                    ));
              },
            )
          ],
        )),
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
                // onPressed: () {
                //showDialog(
                //  context: context,
                //  builder: (BuildContext context) => _buildPopupDialog(context),
                //);
                // },
                onPressed: () async {
                  if (_keyDialogForm.currentState.validate()) {
                    _keyDialogForm.currentState.save();
                    debugPrint(addPatientController.text);

                    /*
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
                    */

                    debugPrint(currentUser['id'].toString());
                    var response = await EndPoints().linkUser(
                        addPatientController.text,
                        currentUser['type'].toString(),
                        token);
                    getPatients();
                    debugPrint(response.toString());
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

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Solicitud de relación'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              "¡Hola! Para poder ver a tu paciente, es necesario mandarle la soliitud de relación ¿Deseas continuar? "),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
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
              var listaUsuarios = await EndPoints().linkUser(
                  addPatientController.text,
                  currentUser['id'].toString(),
                  token);
              debugPrint(listaUsuarios.toString());
              //getPatients();
              Navigator.pop(context);
            }
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('¡Sí!'),
        ),
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

  List<PatientsListItem> _buildPatiensList() {
    return _patients.map((User) => PatientsListItem(User)).toList();
  }
}

class PatientsListItem extends ListTile {
  PatientsListItem(User user)
      : super(
            //title: Text(user.email),
            title: Text("quemado@hotmail.com"),
            //subtitle: Text(user.email),
            leading: CircleAvatar(
              //child: Icon(Icons.account_circle_outlined),
              child: FlatButton(
                onPressed: () {},
                child: const Text('Ver reporte'),
              ),
            ));
}
