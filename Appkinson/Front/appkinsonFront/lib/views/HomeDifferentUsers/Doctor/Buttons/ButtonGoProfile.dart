import 'dart:convert';

import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/profiles/Doctor/DoctorProfileScreen.dart';
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
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          // var doctor = await EndPoints()
          // .getCarer(user, currentUser['id'].toString(), token);
          String token = await Utils().getToken();
          var patient = await EndPoints().getUserName(token);

          var codeList = json.decode(patient);
          //namePatient
          print('hey' + codeList[0]['NAME']);
          nameDoctor = codeList[0]['NAME'];
          emailDoctor = codeList[0]['EMAIL'];
          var res =
              await EndPoints().getPhotoUser(token, codeList[0]['PHOTOPATH']);
          this.setState(() {
            imageFileDoctor = res;
          });
          RoutesDoctor().toDoctorProfile(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey[50],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/obrero.png",
          height: size.height * 0.15,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
