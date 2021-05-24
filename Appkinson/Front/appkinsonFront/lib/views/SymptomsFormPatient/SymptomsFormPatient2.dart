import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ2OFF.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ2ON.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ3.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ4.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ5ON.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ2.dart';
import 'package:flutter/material.dart';

import 'SymptomsFormPatientQ2.dart';

class SymptomsFormPatient2 extends StatefulWidget {
  @override
  _symptomsForm2 createState() => _symptomsForm2();
}

class _symptomsForm2 extends State<SymptomsFormPatient2> {
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
          "Formulario de síntomas",
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
          SymptomsFormPatientQ2ON(),
          SymptomsFormPatientQ3(),
          SymptomsFormPatientQ4(),
          SymptomsFormPatientQ5ON()

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
