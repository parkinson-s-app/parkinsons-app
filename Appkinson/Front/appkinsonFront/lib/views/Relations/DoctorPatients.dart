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

  @override
  void initState() {
    super.initState();

    addPatientController.text = 'Hello';
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
                Expanded(
                  child: PatientsList(kUsers),
                ),
                FlatButton(
                  shape:
                  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                  onPressed: () {
                    addUser();
                  },
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Agregar Paciente", style: TextStyle(fontSize: 20)),
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
                onPressed: () {
                  if (_keyDialogForm.currentState.validate()) {
                    _keyDialogForm.currentState.save();
                    //llamar servicio de agregacion
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
  final List<User> _users;
  PatientsList(this._users);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
            children: _buildPatiensList(),
        )
      );
  }

  List<PatientsListItem> _buildPatiensList(){
    return _users.map((user) => PatientsListItem(user)).toList();
  }
}

class PatientsListItem extends ListTile{

  PatientsListItem(User user) :
      super(

        title : Text(user.name),
        subtitle: Text(user.email),
        leading: CircleAvatar(
          child: Icon(Icons.account_circle_outlined),
        )
      );
}
