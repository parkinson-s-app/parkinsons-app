import 'dart:convert';

import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/Calendar/CalendarScreenView2.dart';
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
          String id = await Utils().getFromToken('id');
          String token = await Utils().getToken();
          String m = await EndPoints().getSymptomsFormPatient(token, id);
          //final DateTime today = DateTime.now();
          var codeList = json.decode(m);
          print('m de mierda $m');
          //List<String> patients = [];
          for (var a = 0; a < codeList.length; a++) {
            //patients.add(codeList[a]['EMAIL']);
            print('formdate: ${codeList[a]['formdate']}');
            DateTime dateBd = DateTime.parse(codeList[a]['formdate']);
            final DateTime startTime = DateTime(
                dateBd.year, dateBd.month, dateBd.day, dateBd.hour, 0, 0);
            final DateTime endTime = startTime.add(const Duration(hours: 1));
            if (codeList[a]['Q1'] == 'on') {
              meetings
                  .add(Meeting('on', startTime, endTime, Colors.green, false));
            }
            if (codeList[a]['Q1'] == 'off') {
              meetings
                  .add(Meeting('off', startTime, endTime, Colors.red, false));
            }
            if (codeList[a]['Q1'] == 'on bueno') {
              meetings.add(Meeting(
                  'on bueno', startTime, endTime, Colors.green[700], false));
            }
            if (codeList[a]['Q1'] == 'off malo') {
              meetings.add(Meeting(
                  'off malo', startTime, endTime, Colors.red[800], false));
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
