import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ0.dart';
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
  final int idPatient;

  NoMotorSymptomsFormQ({Key key, this.idPatient}) : super(key: key);
  @override
  _NoMotorSymptomsFormQ createState() => _NoMotorSymptomsFormQ(this.idPatient);
}

class _NoMotorSymptomsFormQ extends State<NoMotorSymptomsFormQ> {
  final int idPatient;
  _NoMotorSymptomsFormQ(this.idPatient);
  final controller = PageController(
    initialPage: 0,
  );

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    bool shouldPop = true;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WillPopScope(
        onWillPop: () async {
        RestartQ1().setTile();
        RestartQ2().setTile();
        RestartQ3().setTile();
        RestartQ4().setTile();
        RestartQ5().setTile();
        RestartQ6().setTile();
        RestartQ7().setTile();
        RestartQ8().setTile();
        RestartQ9().setTile();
        RestartQ10().setTile();
        RestartQ11().setTile();
        RestartQ12().setTile();
        RestartQ13().setTile();
        RestartQ14().setTile();
        RestartQ15().setTile();
        RestartQ16().setTile();
        RestartQ17().setTile();
        RestartQ18().setTile();
        RestartQ19().setTile();
        RestartQ20().setTile();
        RestartQ21().setTile();
        RestartQ22().setTile();
        RestartQ23().setTile();
        RestartQ24().setTile();
        RestartQ25().setTile();
        RestartQ26().setTile();
        RestartQ27().setTile();
        RestartQ28().setTile();
        RestartQ29().setTile();
        RestartQ30().setTile();
          return shouldPop;
        },
      child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Síntomas No Motores",
        ),
        backgroundColor: Colors.blue,
      ),
      body: PageView(
        controller: controller,
        scrollDirection: Axis.vertical,
        children: [
          NoMotorSymptomsFormQ0(),
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
          NoMotorSymptomsFormQ30(
            idPatient: idPatient,
          ),
        ],
      ),
    ),
  );
  }
}
