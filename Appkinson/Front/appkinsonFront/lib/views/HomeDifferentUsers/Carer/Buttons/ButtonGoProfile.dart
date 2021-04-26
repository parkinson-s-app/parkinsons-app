import 'dart:convert';

import 'package:appkinsonFront/routes/RoutesCarer.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/profiles/Carer/CarerProfileScreen.dart';
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
      child: RaisedButton(
        shape: CircleBorder(),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          String token = await Utils().getToken();
          print(token);
          var patientPhoto = await EndPoints().getUserName(token);
          var patient = await Utils().getFromToken('nombre');
          var email = await Utils().getFromToken('email');

          var codeList = json.decode(patientPhoto);
          //namePatient
          //print('hey' + codeList[0]['NAME']);
          nameCarer = codeList[0]['NAME'];
          emailCarer = email;

          var res =
              await EndPoints().getPhotoUser(token, codeList[0]['PHOTOPATH']);
          this.setState(() {
            imageFileCarer = res;
          });

          //print(imageFilePatient.uri.toFilePath());

          // var carer = await EndPoints()
          // .getCarer(user, currentUser['id'].toString(), token);
          RoutesCarer().toCarerProfile(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey[50],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/4-PERFIL.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
