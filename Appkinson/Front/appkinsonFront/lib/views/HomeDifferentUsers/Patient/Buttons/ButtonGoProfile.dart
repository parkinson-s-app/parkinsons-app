import 'dart:convert';
import 'dart:io';

import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:appkinsonFront/views/profiles/Carer/CarerProfileScreen.dart';
import 'package:appkinsonFront/views/profiles/Patient/PatientProfileScreen.dart';
import 'package:flutter/material.dart';

//import '../../Register/RegisterPage.dart';

class ButtonGoProfile extends StatefulWidget {
  @override
  _ButtonGoProfileState createState() => _ButtonGoProfileState();
}

class _ButtonGoProfileState extends State<ButtonGoProfile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          var patient = await EndPoints().getUserName(token);

          var codeList = json.decode(patient);
          //namePatient
          print('hey' + codeList[0]['NAME']);
          namePatient = codeList[0]['NAME'];
          var res =
              await EndPoints().getPhotoUser(token, codeList[0]['PHOTOPATH']);
          this.setState(() {
            imageFilePatient = res;
          });

          print(imageFilePatient.uri.toFilePath());
          RoutesPatient().toPatientProfile(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey[50],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/obrero.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
