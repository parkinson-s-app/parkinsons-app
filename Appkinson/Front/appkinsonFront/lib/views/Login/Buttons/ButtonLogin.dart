import 'dart:convert';

import 'package:flutter/material.dart';
import '../../HomeDifferentUsers/Admin/AdminHomePage.dart';
import '../../HomeDifferentUsers/Doctor/DoctorHomePage.dart';
import '../../HomeDifferentUsers/Patient/PatientHomePage.dart';
import "../InputFieldLogin.dart";
import '../../../model/User.dart';
import '../../HomeDifferentUsers/Carer/CarerHomePage.dart';
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
          var user = await m.send() as User;
          debugPrint(user.email);

          /*
            parte del decodificado del token y 
            ontención del payload. Posteriormente
            obtención del tipo de usuario para 
            dirijirlo a la pantalla correspondiente
          */

          token = await EndPoints().authUser(user);
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
          debugPrint(currentUser['type']);
          debugPrint(decoded);

          if (currentUser['type'] == 'Cuidador') {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => CarerHomePage()));
          }
          if (currentUser['type'] == 'Paciente') {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => PatientHomePage()));
          }
          if (currentUser['type'] == 'Doctor') {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => DoctorHomePage()));
          }
          if (currentUser['type'] == 'Admin') {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => AdminHomePage()));
          }
        },
        color: Colors.blue,
        textColor: Colors.white,
        child: Text("Iniciar Sesión", style: TextStyle(fontSize: 15)),
      ),
    );
  }
}
