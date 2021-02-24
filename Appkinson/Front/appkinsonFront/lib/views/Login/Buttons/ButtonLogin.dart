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

          /*
            parte del decodificado del token y 
            ontención del payload. Posteriormente
            obtención del tipo de usuario para 
            dirijirlo a la pantalla correspondiente
          */

          token = await EndPoints().authUser(user);
          
          debugPrint(token);
          Map responseJson = json.decode(token);
          if(responseJson["person"] != null){
            debugPrint("contraseña invalida");
            invalid(0, context);
          }else if(responseJson["message"] != null){
            debugPrint("correo invalido");
            invalid(1, context);
          }else{

          currentUser = Utils().tokenDecoder(token);
          /*
          debugPrint(token);
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
          //debugPrint(currentUser['type']);
          // debugPrint(decoded);
          
          if (currentUser['type'] == 'Cuidador') {
            RoutesCarer().toCarerHome(context);
          }
          if (currentUser['type'] == 'Paciente') {
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