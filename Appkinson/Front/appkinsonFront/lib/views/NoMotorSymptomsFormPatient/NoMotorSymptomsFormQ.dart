import 'package:flutter/material.dart';

import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ1.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ2.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ3.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ4.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ5.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ6.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ7.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ8.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ9.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ10.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ11.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ12.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ13.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ14.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ15.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ16.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ17.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ18.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ19.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ20.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ21.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ22.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ23.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ24.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ25.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ26.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ27.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ28.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ29.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ30.dart';

class NoMotorSymptomsFormQ extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ createState() => _NoMotorSymptomsFormQ();
}

class _NoMotorSymptomsFormQ extends State<NoMotorSymptomsFormQ> {
  final controller = PageController(
    initialPage: 0,
  );

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Formulario emocional",
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
          NoMotorSymptomsFormQ1(),
          NoMotorSymptomsFormQ2(),
          NoMotorSymptomsFormQ3(),
          NoMotorSymptomsFormQ4(),
          NoMotorSymptomsFormQ5(),
          NoMotorSymptomsFormQ6(),
          NoMotorSymptomsFormQ7(),
          NoMotorSymptomsFormQ8(),
          NoMotorSymptomsFormQ9(),
          NoMotorSymptomsFormQ10(),
          NoMotorSymptomsFormQ11(),
          NoMotorSymptomsFormQ12(),
          NoMotorSymptomsFormQ13(),
          NoMotorSymptomsFormQ14(),
          NoMotorSymptomsFormQ15(),
          NoMotorSymptomsFormQ16(),
          NoMotorSymptomsFormQ17(),
          NoMotorSymptomsFormQ18(),
          NoMotorSymptomsFormQ19(),
          NoMotorSymptomsFormQ20(),
          NoMotorSymptomsFormQ21(),
          NoMotorSymptomsFormQ22(),
          NoMotorSymptomsFormQ23(),
          NoMotorSymptomsFormQ24(),
          NoMotorSymptomsFormQ25(),
          NoMotorSymptomsFormQ26(),
          NoMotorSymptomsFormQ27(),
          NoMotorSymptomsFormQ28(),
          NoMotorSymptomsFormQ29(),
          NoMotorSymptomsFormQ30(),
        ],
      ),
    );
  }
}
