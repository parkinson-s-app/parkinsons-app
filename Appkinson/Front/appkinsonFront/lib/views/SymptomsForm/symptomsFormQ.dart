import 'dart:io';
import 'dart:ui';
import 'package:appkinsonFront/views/SymptomsForm/videoPluguin.dart';
import 'package:flutter/material.dart';
import '../SymptomsForm/symptomsFormQ1.dart';
import '../SymptomsForm/symptomsFormQ2.dart';
import '../SymptomsForm/symptomsFormQ3.dart';
import '../SymptomsForm/symptomsFormQ4.dart';
import '../SymptomsForm/symptomsFormQ5.dart';
import '../SymptomsForm/symptomsFormQ6.dart';
import '../SymptomsForm/symptomsFormQ7.dart';
import '../SymptomsForm/symptomsFormQ8.dart';
import '../SymptomsForm/symptomsFormQ9.dart';
import '../SymptomsForm/symptomsFormQ10.dart';
import '../SymptomsForm/symptomsFormQ11.dart';
import '../SymptomsForm/symptomsFormQ12.dart';
import '../SymptomsForm/symptomsFormQ13.dart';
import '../SymptomsForm/symptomsFormQ14.dart';
import '../SymptomsForm/symptomsFormQ15.dart';
import '../SymptomsForm/symptomsFormQ16.dart';
import '../SymptomsForm/symptomsFormQ17.dart';
import '../SymptomsForm/symptomsFormQ29.dart';

class symptomsFormQ extends StatefulWidget {
  @override
  _symptomsFormQ createState() => _symptomsFormQ();
}

class _symptomsFormQ extends State<symptomsFormQ> {

  final controller=PageController(
    initialPage: 1,
  );

  int _current=0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
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
          symptomsFormQ1(),
          symptomsFormQ2(),
          symptomsFormQ3(),
          symptomsFormQ4(),
          symptomsFormQ5(),
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
          symptomsFormQ29(),
        ],
      ),
    );
  }
}