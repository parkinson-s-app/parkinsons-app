import 'dart:convert';

import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import '../Relations/DoctorPatientAdd.dart';
//import 'package:appkinsonFront/views/Calendar/CalendarScreenView2.dart';
import 'package:appkinsonFront/views/Calendar/CalendarScreenView2Doctor.dart';
import 'package:appkinsonFront/views/ToolBox/AboutExcercises/ExcercisesList.dart';
import 'package:flutter/material.dart';
import '../../model/User.dart';

class DoctorPatientsAdd extends StatefulWidget {
  @override
  DoctorPatientsCustomAdd createState() => DoctorPatientsCustomAdd();
}

var codeListPatients;

class DoctorPatientsCustomAdd extends State<DoctorPatientsAdd> {
  final TextEditingController addPatientController =
      new TextEditingController();
  final GlobalKey<FormState> _keyDialogForm = new GlobalKey<FormState>();
  TextEditingController editingController2 = TextEditingController();
  List<User> patientsAdd = [];
  List<User> patientsAddAux = [];
  List<User> _patientsAdd = [];
  List<User> items = [];

  @override
  void initState() {
    getPatientsAdd();
    super.initState();
  }

  
  getPatientsAdd() async {
   
    User patientAdd;
    //Pedir lista de pacientes relacionados
    debugPrint("pidiendo pacientes");
    String tipe = await Utils().getFromToken('type');
    String id = await Utils().getFromToken('id');
    String token = await Utils().getToken();
    var patientsAux = await EndPoints().getUnrelatedPatients(token, tipe);
    debugPrint("pacientes pedidos");
    codeListPatients = json.decode(patientsAux);
    //List<User> patients = [];
    debugPrint(codeListPatients.toString());
    debugPrint("--------");
    debugPrint(codeListPatients[0]['Email']);
    for (var a = 0; a < codeListPatients.length; a++) {
      //patients.add(codeList[a]['EMAIL']);
      patientAdd = new User();
      patientAdd.email = codeListPatients[a]['Email'];
      patientAdd.id = codeListPatients[a]['IdUser'];
      _patientsAdd.add(patientAdd);
    }
    debugPrint("llenando");
    setState(() {
      items = _patientsAdd;
    });
    setState(() {
      patientsAdd = _patientsAdd;
    });
  }

  void filterSearchResults(String query) {
    List<User> dummySearchList = List<User>();
    dummySearchList.addAll(patientsAdd);
    if(query.isNotEmpty) {
      List<User> dummyListData = List<User>();
      dummySearchList.forEach((item) {
        if(item.email.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items = dummyListData;
      });
      return;
    } else {
      setState(() {
        items = patientsAdd;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pacientes no agregados'),
        ),
        body: SingleChildScrollView(
          //physics: ScrollPhysics(),
          child: Container(
          child: Column(
          key: UniqueKey(),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController2,
                decoration: InputDecoration(
                    hintText: "Buscar",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            ListView.separated(
              //scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: (items.length),
              itemBuilder: (context, index) {
                User patient = items[index];
                return ListTile(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context, patient.email),
                      );
                      //getPatients();
                      },
                      title: Text(patient.email, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.4)),
                      //subtitle: Text(user.email),
                      leading: CircleAvatar(
                        child: Icon(Icons.account_circle_outlined),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    dense:true,  
                  );
              },
              separatorBuilder: (context, index){
                return Divider(thickness: 2, color: Colors.blue[700], indent: 15, endIndent: 20);
              },
            ),
            
          ],
        ))
      ),
      ),
    );
  }
  
}


class PatientsList extends StatelessWidget {
  List<User> _patients;

  PatientsList(this._patients);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
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

Widget _buildPopupDialog(BuildContext context, String email) {
  return new AlertDialog(
    title: Text("Agregar a "+ email),
    actions: <Widget>[
      new FlatButton(
        onPressed: () async {
          String tipe = await Utils().getFromToken('type');
          String token = await Utils().getToken();
          var response = await EndPoints().linkUser(
              email,
              tipe,
              token);
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Aceptar'),
      ),new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Cancelar'),
      )
    ],
  );
}