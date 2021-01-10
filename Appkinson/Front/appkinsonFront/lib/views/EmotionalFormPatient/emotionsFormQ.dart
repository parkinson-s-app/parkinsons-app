import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../EmotionalFormPatient/emotionsFormQ1.dart';
import '../EmotionalFormPatient/emotionsFormQ2.dart';
import '../EmotionalFormPatient/emotionsFormQ3.dart';
import '../EmotionalFormPatient/emotionsFormQ4.dart';
import '../EmotionalFormPatient/emotionsFormQ5.dart';
import '../EmotionalFormPatient/emotionsFormQ6.dart';
import '../EmotionalFormPatient/emotionsFormQ7.dart';
import '../EmotionalFormPatient/emotionsFormQ8.dart';
import '../EmotionalFormPatient/emotionsFormQ9.dart';
import '../EmotionalFormPatient/emotionsFormQ10.dart';
import '../EmotionalFormPatient/emotionsFormQ11.dart';
import '../EmotionalFormPatient/emotionsFormQ12.dart';
import '../EmotionalFormPatient/emotionsFormQ13.dart';
import '../EmotionalFormPatient/emotionsFormQ14.dart';
import '../EmotionalFormPatient/emotionsFormQ15.dart';
import '../EmotionalFormPatient/emotionsFormQ16.dart';
import '../EmotionalFormPatient/emotionsFormQ17.dart';
import '../EmotionalFormPatient/emotionsFormQ18.dart';
import '../EmotionalFormPatient/emotionsFormQ19.dart';
import '../EmotionalFormPatient/emotionsFormQ20.dart';
import '../EmotionalFormPatient/emotionsFormQ21.dart';
import '../EmotionalFormPatient/emotionsFormQ22.dart';
import '../EmotionalFormPatient/emotionsFormQ23.dart';
import '../EmotionalFormPatient/emotionsFormQ24.dart';
import '../EmotionalFormPatient/emotionsFormQ25.dart';
import '../EmotionalFormPatient/emotionsFormQ26.dart';
import '../EmotionalFormPatient/emotionsFormQ27.dart';
import '../EmotionalFormPatient/emotionsFormQ28.dart';
import '../EmotionalFormPatient/emotionsFormQ29.dart';
import '../EmotionalFormPatient/emotionsFormQ30.dart';

class emotionsFormQ extends StatefulWidget {
  @override
  _emotionsFormQ createState() => _emotionsFormQ();
}

class _emotionsFormQ extends State<emotionsFormQ> {

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
          "¿Ha tenido alguno de los siguientes problemas durante el mes pasado?",
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
          /*
          emotionsFormQ1(),
          emotionsFormQ2(),
          emotionsFormQ3(),
          emotionsFormQ4(),
          emotionsFormQ5(),
          emotionsFormQ6(),
          emotionsFormQ7(),
          emotionsFormQ8(),
          emotionsFormQ9(),
          emotionsFormQ10(),
          emotionsFormQ11(),
          emotionsFormQ12(),
          emotionsFormQ13(),
          emotionsFormQ14(),
          emotionsFormQ15(),
          emotionsFormQ16(),
          emotionsFormQ17(),
          emotionsFormQ18(),
          emotionsFormQ19(),
          emotionsFormQ20(),
          emotionsFormQ21(),
          emotionsFormQ22(),
          emotionsFormQ23(),
          emotionsFormQ24(),
          emotionsFormQ25(),
          emotionsFormQ26(),
          emotionsFormQ27(),
          emotionsFormQ28(),
          emotionsFormQ29(),
          emotionsFormQ30(),
          */
        ],
      ),
    );
  }
}