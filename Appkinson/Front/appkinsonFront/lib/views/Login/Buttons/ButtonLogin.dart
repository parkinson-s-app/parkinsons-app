import 'dart:convert';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/RelationRequest/relationRequestPlugin.dart';
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
          debugPrint("------");

          /*
            parte del decodificado del token y 
            ontención del payload. Posteriormente
            obtención del tipo de usuario para 
            dirijirlo a la pantalla correspondiente
          */

          token = await EndPoints().authUser(user);

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
        },
        color: Colors.blue,
        textColor: Colors.white,
        child: Text("Iniciar Sesión", style: TextStyle(fontSize: 15)),
      ),
    );
  }
}
