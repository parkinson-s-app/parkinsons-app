import 'dart:convert';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/routes/RoutesAdmin.dart';
import 'package:appkinsonFront/routes/RoutesCarer.dart';
import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:flutter/material.dart';
import "../InputFieldLogin.dart";
import '../../../services/EndPoints.dart';

Map currentUser;
var token;

class ButtonLogin extends StatefulWidget {
  @override
  _FormButtonLogin createState() => _FormButtonLogin();
}

class _FormButtonLogin extends State<ButtonLogin> {
  @override
  void initState() {
    super.initState();
    Utils().initWorkmanager();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        padding: EdgeInsets.symmetric(horizontal: 50),
        onPressed: () async {
          var m = new metod();
          var user = await m.send();
          debugPrint(user.email);
          debugPrint(user.password);
          debugPrint("------");

      

          token = await EndPoints().authUser(user);

          debugPrint(token);
          Map responseJson = json.decode(token);
          if (responseJson["person"] != null) {
            debugPrint("contraseña invalida");
            invalid(0, context);
          } else if (responseJson["message"] != null) {
            debugPrint("correo invalido");
            invalid(1, context);
          } else {
            await Utils().saveToken(responseJson['token']);
            currentUser = Utils().tokenDecoder(token);
            cleanLogin();
            if (currentUser['type'] == 'Cuidador') {
              RoutesCarer().toCarerHome(context);
            }
            if (currentUser['type'] == 'Paciente') {
              bool isSetBackground = await Utils().isSetBackgroundTask();
              if (isSetBackground) {
                print('esta seteaada');
              }
              await Utils().setTaskGetAlarms();
              debugPrint("paciente");
              //getRelationsRequest();
              RoutesPatient().toPatientHome(context);
            }
            if (currentUser['type'] == 'Doctor') {
              RoutesDoctor().toDoctorHome(context);
            }
            if (currentUser['type'] == 'Admin') {
              RoutesAdmin().toAdminHome(context);
            }
          }
        },
        color: Colors.blue,
        textColor: Colors.white,
        child: Text("Iniciar Sesión", style: TextStyle(fontSize: 15)),
      ),
    );
  }
}

invalid(int reason, context) {
  debugPrint("invalidez");
  String invalidReason;
  if (reason == 0) {
    invalidReason = "Contraseña invalida";
  }
  if (reason == 1) {
    invalidReason = "Email incorrecto";
  }
  showDialog(
    context: context,
    builder: (BuildContext context) =>
        _buildPopupDialog(context, invalidReason),
  );
}

Widget _buildPopupDialog(BuildContext context, String invalidReason) {
  return new AlertDialog(
    title: Text(invalidReason),
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
