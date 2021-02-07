import 'dart:io';
import 'dart:ui';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatient2.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatient3.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ2OFF.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ2ON.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ2.dart';
import 'package:appkinsonFront/views/SymptomsFormDoctor/videoPluguin.dart';
import 'package:flutter/material.dart';

import 'SymptomsFormPatientQ1.dart';
import 'SymptomsFormPatientQ2.dart';

class SymptomsFormPatient extends StatefulWidget {
  @override
  _symptomsForm createState() => _symptomsForm();
}

class _symptomsForm extends State<SymptomsFormPatient> {
  final controller = PageController(
    initialPage: 0,
  );

  int _current = 0;

  Widget decideForm() {
    debugPrint(BringAnswerPatient2().send().toString());

    if (BringAnswerPatient2().send().toString() == '1') {
      return SymptomsFormPatientQ2ON();
    } else {
      return SymptomsFormPatientQ2OFF();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Formulario de sintomas",
        ),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3.0),
          ),
        ],
      ),
      body: PageView(
        controller: controller,
        scrollDirection: Axis.vertical,
        children: [
          SymptomsFormPatientQ1(),
          SymptomsFormPatientQ2(),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
            onPressed: () async {
              // addUsers('jorge', '1234');
              if (BringAnswerPatient2().send().toString() == 'ON') {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => SymptomsFormPatient2()));
              } else {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => SymptomsFormPatient3()));
              }
            },
            padding: EdgeInsets.symmetric(horizontal: 50),
            color: Color.fromRGBO(0, 160, 227, 1),
            textColor: Colors.white,
            child: Text("Pulsa para continuar", style: TextStyle(fontSize: 15)),
          ),
          //debugPrint('hola');
          //debugPrint(BringAnswerPatient2().send());
          // symptomsFormPatientQ3(),
          //symptomsFormPatientQ4(),
          //symptomsFormPatientQ5(),

          /*symptomsFormQ17(),
          symptomsFormQ18(),
          symptomsFormQ19(),
          symptomsFormQ20(),
          symptomsFormQ21(),
          symptomsFormQ22(),
          symptomsFormQ23(),
          symptomsFormQ24(),
          symptomsFormQ25(),
          symptomsFormQ26(),
          symptomsFormQ27(),
          symptomsFormQ28(),*/
        ],
      ),
    );
  }
}
