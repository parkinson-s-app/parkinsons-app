import 'dart:convert';

import 'package:appkinsonFront/routes/RoutesCarer.dart';
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
      debugPrint("agregando paciente....");
      debugPrint(patient.email);
    }
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
        ),
        
        body: SingleChildScrollView(
            child: Column(
            key: UniqueKey(),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  //filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    hintText: "Buscar",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: patients.length,
              itemBuilder: (context, index) {
                User patient = patients[index];
                return ListTile(
                    onTap: (){
                      String selectId;
                      selectId = patient.id.toString();
                      RoutesCarer().toInteractionCarerPatient(context, patient.id);
                    },
                    title: Text(patient.email, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
                    //subtitle: Text(user.email),
                    leading: CircleAvatar(
                      child: Icon(Icons.account_circle_outlined),
                    ),
                    trailing: TextButton(
                      onPressed: () async{
                        debugPrint("eliminar");
                        EndPoints().unlinkedPatient(patient.id.toString());
                        setState(() {
                          patients.remove(patient); 
                        });
                      },
                      child: Icon(Icons.delete_forever, size: 40),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  dense:true,  
                );
              },
              separatorBuilder: (context, index){
                return Divider(thickness: 2, color: Colors.blue[700], indent: 10, endIndent: 10);
              },
            ),
            
          ],
        )),
        floatingActionButton:FloatingActionButton(
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
                    debugPrint(currentUser['id'].toString());
                    */
                    String id = await Utils().getFromToken('id');
                    String token = await Utils().getToken();
                    var listaUsuarios = await EndPoints().linkUserCarer(
                        addPatientController.text,
                        id,
                        token);
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

  List<PatientsListItem> _buildPatiensList() {
    return _patients.map((User) => PatientsListItem(User)).toList();
  }
}

class PatientsListItem extends ListTile {
  PatientsListItem(User user)
      : super(
            title: Text(user.email),
            //subtitle: Text(user.email),
            leading: CircleAvatar(
              child: Icon(Icons.account_circle_outlined),
            ));
}
