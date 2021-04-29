import 'dart:convert';

import 'package:appkinsonFront/routes/RoutesCarer.dart';
import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Calendar/CalendarScreenView2Carer.dart';
import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/ToolBox/AboutFood/FoodList.dart';
import 'package:flutter/material.dart';
import '../../model/User.dart';

class CarerPatients extends StatefulWidget {
  @override
  CarerPatientsCustom createState() => CarerPatientsCustom();
}

var codeListPatients;

class CarerPatientsCustom extends State<CarerPatients> {
  final TextEditingController addPatientController =
      new TextEditingController();
  final TextEditingController editingController = new TextEditingController();
  final GlobalKey<FormState> _keyDialogForm = new GlobalKey<FormState>();
  TextEditingController editingController2 = TextEditingController();
  List<User> items = [];
  List<User> patients = [];
  List<User> patientsAdd = [];
  bool isSearching = false;
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
    String tipe = await Utils().getFromToken('type');
    String id = await Utils().getFromToken('id');
    String token = await Utils().getToken();
    debugPrint("pidiendo pacientes");
    debugPrint(id);
    debugPrint(tipe);
    debugPrint(token);
    var patientsAux = await EndPoints().linkedUser(token, tipe);
    codeListPatients = json.decode(patientsAux);
    //List<User> patients = [];
    debugPrint(codeListPatients.toString());
    for (var a = 0; a < codeListPatients.length; a++) {
      //patients.add(codeList[a]['EMAIL']);
      patient = new User();
      patient.email = codeListPatients[a]['EMAIL'];
      patient.id = codeListPatients[a]['ID_USER'];
      _patients.add(patient);
    }
    setState(() {
      items = _patients;
    });
    setState(() {
      patientsAdd = _patients;
    });
    /*
    for (var a = 0; a < patientsAux.length; a++) {
      User u = new User();
      u.email = patientsAux[a]['ID_USER'];
      _patients.add(u);
      debugPrint("------");
      debugPrint(u.email);
      debugPrint("agregando paciente....");
      debugPrint(patient.email);
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

  void filterSearchResults(String query) {
    List<User> dummySearchList = List<User>();
    dummySearchList.addAll(patientsAdd);
    if (query.isNotEmpty) {
      List<User> dummyListData = List<User>();
      dummySearchList.forEach((item) {
        if (item.email.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        patients = dummyListData;
      });
      return;
    } else {
      setState(() {
        patients = patientsAdd;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: !isSearching
              ? Text('Pacientes no agregados')
              : TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  controller: editingController2,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Buscar",
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 3.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[400], width: 2.0),
                    ),
                  ),
                ),
          actions: <Widget>[
            !isSearching
                ? IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        this.isSearching = !this.isSearching;
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        this.isSearching = !this.isSearching;
                      });
                    },
                  )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          key: UniqueKey(),
          children: <Widget>[
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: patients.length,
              itemBuilder: (context, index) {
                User patient = patients[index];
                return ListTile(
                  onTap: () async {
                    String selectId;
                    meetingsCarer = <Meeting>[];
                    //SymptomsFormPatientM m= await EndPoints().getSymptomsFormPatient(token,currentUser['id'].toString());\
                    selectId = patient.id.toString();
                    /* for (var a = 0; a < codeListPatients.length; a++) {
                        //patients.add(codeList[a]['EMAIL']);

                        if (codeListPatients[a]['EMAIL'] == patient.email) {
                          selectId = codeListPatients[a]['ID_USER'].toString();
                        }
                      } */
                    String token = await Utils().getToken();
                    String m = await EndPoints()
                        .getSymptomsFormPatient(token, selectId);
                    //final DateTime today = DateTime.now();
                    listPacientes = m;

                    var codeList = json.decode(m);
                    //List<String> patients = [];
                    for (var a = 0; a < codeList.length; a++) {
                      //patients.add(codeList[a]['EMAIL']);
                      DateTime dateBd = DateTime.parse(codeList[a]['formdate']);
                      final DateTime startTime = DateTime(dateBd.year,
                          dateBd.month, dateBd.day, dateBd.hour, 0, 0);
                      final DateTime endTime =
                          startTime.add(const Duration(hours: 1));
                      if (codeList[a]['Q1'] == 'on' ||
                          codeList[a]['Q1'] == 'ON') {
                        meetingsCarer.add(Meeting(
                            'ON', startTime, endTime, Colors.green, false));
                      }
                      if (codeList[a]['Q1'] == 'off' ||
                          codeList[a]['Q1'] == 'OFF') {
                        meetingsCarer.add(Meeting(
                            'off', startTime, endTime, Colors.red, false));
                      }
                      if (codeList[a]['Q1'] == 'on bueno' ||
                          codeList[a]['Q1'] == 'ON Bueno') {
                        meetingsCarer.add(Meeting('ON Bueno', startTime,
                            endTime, Colors.green[700], false));
                      }
                      if (codeList[a]['Q1'] == 'off malo' ||
                          codeList[a]['Q1'] == 'OFF Malo') {
                        meetingsCarer.add(Meeting('OFF Malo', startTime,
                            endTime, Colors.red[800], false));
                      }
                    }
                    RoutesCarer()
                        .toInteractionCarerPatient(context, patient.id);
                    //RoutesCarer().toCalendarCarer(context);
                  },
                  title: Text(patient.email,
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 1.5)),
                  //subtitle: Text(user.email),
                  leading: CircleAvatar(
                    child: Icon(Icons.account_circle_outlined),
                  ),
                  trailing: TextButton(
                    onPressed: () async {
                      debugPrint("eliminar");
                      EndPoints().unlinkedPatient(patient.id.toString());
                      setState(() {
                        patients.remove(patient);
                      });
                    },
                    child: Icon(Icons.delete, size: 40),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  dense: true,
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                    thickness: 1,
                    color: Colors.grey[350],
                    indent: 10,
                    endIndent: 10);
              },
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
          backgroundColor: Colors.blue[800],
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            //addUser();
            RoutesCarer().toAddUser(context);
            debugPrint(addPatientController.text);
          },
        ),
      ),
    );
  }

  /*Future addUser() {
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
                    String id = await Utils().getFromToken('id');
                    String token = await Utils().getToken();
                    var listaUsuarios = await EndPoints().linkUserCarer(
                        addPatientController.text,
                        id,
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
  }*/

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
              String token = await Utils().getToken();
              String id = await Utils().getFromToken('id');
              // debugPrint(currentUser['id'].toString());
              var listaUsuarios = await EndPoints()
                  .linkUser(addPatientController.text, id, token);
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
