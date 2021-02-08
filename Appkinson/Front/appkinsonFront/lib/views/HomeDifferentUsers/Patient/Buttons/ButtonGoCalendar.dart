import 'dart:convert';

import 'package:appkinsonFront/model/SymptomsFormPatientM.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Calendar/CalendarScreen.dart';
import 'package:appkinsonFront/views/Calendar/CalendarScreenView2.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:flutter/material.dart';
import '../../../../routes/RoutesPatient.dart';

//import '../../Register/RegisterPage.dart';

class ButtonGoCalendar extends StatelessWidget {
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
          meetings = <Meeting>[];
          //SymptomsFormPatientM m= await EndPoints().getSymptomsFormPatient(token,currentUser['id'].toString());\
          String m = await EndPoints()
              .getSymptomsFormPatient(token, currentUser['id'].toString());
          //final DateTime today = DateTime.now();
          var codeList = json.decode(m);
          //List<String> patients = [];
          for (var a = 0; a < codeList.length; a++) {
            //patients.add(codeList[a]['EMAIL']);
            DateTime dateBd = DateTime.parse(codeList[a]['formdate']);
            final DateTime startTime = DateTime(
                dateBd.year, dateBd.month, dateBd.day, dateBd.hour, 0, 0);
            final DateTime endTime = startTime.add(const Duration(hours: 1));
            if (codeList[a]['Q2'] == 'ON') {
              meetings.add(Meeting(
                  'on', startTime, endTime, const Color(0xFF0F8644), false));
            } else {
              meetings
                  .add(Meeting('off', startTime, endTime, Colors.red, false));
            }
          }
          RoutesPatient().toCalendar(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey[50],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/calendario.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
