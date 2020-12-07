import 'dart:convert';

import 'package:flutter/material.dart';
import '../../HomeDifferentUsers/Admin/AdminHomePage.dart';
import '../../HomeDifferentUsers/Doctor/DoctorHomePage.dart';
import '../../HomeDifferentUsers/Patient/PatientHomePage.dart';
import "../InputFieldLogin.dart";
import 'dart:async';
import '../../../model/User.dart';
import '../../HomeDifferentUsers/Patient/PatientHomePage.dart';
import '../../HomeDifferentUsers/Admin/AdminHomePage.dart';
import '../../HomeDifferentUsers/Carer/CarerHomePage.dart';
import '../../HomeDifferentUsers/Doctor/DoctorHomePage.dart';
import '../../../services/EndPoints.dart';

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
          String save = await EndPoints().authUser(user);
          debugPrint(save);
          if (save == 'Good') {
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
