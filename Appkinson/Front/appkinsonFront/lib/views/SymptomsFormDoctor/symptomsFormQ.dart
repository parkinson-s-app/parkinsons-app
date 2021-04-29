import 'package:flutter/material.dart';
import '../SymptomsFormDoctor/symptomsFormQ1.dart';
import '../SymptomsFormDoctor/symptomsFormQ2.dart';
import '../SymptomsFormDoctor/symptomsFormQ3.dart';
import '../SymptomsFormDoctor/symptomsFormQ4.dart';
import '../SymptomsFormDoctor/symptomsFormQ5.dart';
import '../SymptomsFormDoctor/symptomsFormQ6.dart';
import '../SymptomsFormDoctor/symptomsFormQ7.dart';
import '../SymptomsFormDoctor/symptomsFormQ8.dart';
import '../SymptomsFormDoctor/symptomsFormQ9.dart';
import '../SymptomsFormDoctor/symptomsFormQ10.dart';
import '../SymptomsFormDoctor/symptomsFormQ11.dart';
import '../SymptomsFormDoctor/symptomsFormQ12.dart';
import '../SymptomsFormDoctor/symptomsFormQ13.dart';
import '../SymptomsFormDoctor/symptomsFormQ14.dart';
import '../SymptomsFormDoctor/symptomsFormQ15.dart';
import '../SymptomsFormDoctor/symptomsFormQ16.dart';
import '../SymptomsFormDoctor/symptomsFormQ29.dart';

class symptomsFormQ extends StatefulWidget {
  @override
  _symptomsFormQ createState() => _symptomsFormQ();
}

class _symptomsFormQ extends State<symptomsFormQ> {
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
          "Formulario de Síntomas",
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
          symptomsFormQ1(),
          symptomsFormQ2(),
          symptomsFormQ3(),
          symptomsFormQ4(),
          symptomsFormQ5(),
          /*
          symptomsFormQ6(),
          symptomsFormQ7(),
          symptomsFormQ8(),
          symptomsFormQ9(),
          symptomsFormQ10(),
          symptomsFormQ11(),
          symptomsFormQ12(),
          symptomsFormQ13(),
          symptomsFormQ14(),
          symptomsFormQ15(),
          symptomsFormQ16(),
          symptomsFormQ17(),
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
          symptomsFormQ29(),
        ],
      ),
    );
  }
}
