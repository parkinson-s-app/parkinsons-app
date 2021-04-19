import 'dart:convert';

import 'package:appkinsonFront/routes/RoutesCarer.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/profiles/Carer/CarerProfileScreen.dart';
import 'package:flutter/material.dart';

//import '../../Register/RegisterPage.dart';

class ButtonGoProfile extends StatelessWidget {
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
          var token = await Utils().getToken();
          //print(token + 'hey');
          //var patient = await EndPoints().getUserName(token);

          //var codeList = json.decode(patient);
          //namePatient
          //print('hey' + codeList[0]['NAME']);
          //nameCarer = codeList[0]['NAME'];
          //emailCarer = codeList[0]['EMAIL'];

          /* var res =
              await EndPoints().getPhotoUser(token, codeList[0]['PHOTOPATH']);
          this.setState(() {
            imageFilePatient = res;
          });*/

          //print(imageFilePatient.uri.toFilePath());

          // var carer = await EndPoints()
          // .getCarer(user, currentUser['id'].toString(), token);
          RoutesCarer().toCarerProfile(context);
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
