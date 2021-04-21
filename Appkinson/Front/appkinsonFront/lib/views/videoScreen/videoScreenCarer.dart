import 'dart:io';
import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:appkinsonFront/views/Calendar/CalendarScreenView2.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ1.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ2.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ2ON.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ3.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ4.dart';
import 'package:appkinsonFront/model/SymptomsFormPatientM.dart';

import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:appkinsonFront/services/EndPoints.dart';

import 'package:appkinsonFront/views/SymptomsFormDoctor/videoPluguin.dart';

import 'package:flutter/material.dart';

class VideoScreenCarer extends StatefulWidget {
  @override
  _symptomsFormQ29 createState() => _symptomsFormQ29();
}

File fileMediaCarer;

class _symptomsFormQ29 extends State<VideoScreenCarer> {
  MediaSource source;
  int selectedStateRadio = 0;
  int selectedDyskinesiaRadio = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 2),
                        bottom: BorderSide(width: 1)),
                  ),
                  child: fileMediaCarer == null
                      ? Icon(Icons.play_circle_outline, size: 240)
                      : (source == MediaSource.image
                          ? Image.file(fileMediaCarer)
                          : VideoWidget(fileMediaCarer)),
                )),
                const SizedBox(height: 24),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                ButtonTheme(
                  minWidth: 120.0,
                  height: 50.0,
                  child: RaisedButton(
                    child: Text('Volver'),
                    shape: StadiumBorder(),
                    //onPressed: () => save(),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      /*
                      SymptomsFormPatientM patientForm =
                          new SymptomsFormPatientM();

                      patientForm.q1 = BringAnswerPatient1().send();
                      patientForm.q2 = BringAnswerPatient2().send();
                      //patientForm.q3 = BringAnswer2On().send();
                      //patientForm.q4 = BringAnswerPatientQ3().send();
                      //patientForm.q5 = BringAnswerPatientQ4().send();

                      patientForm.video = fileMedia;
                      patientForm.formDate = dateChoosed;

                      debugPrint('enviado');
                      var savedDone = await EndPoints()
                          .registerSymptomsFormPatient(
                              patientForm, currentUser['id'].toString(), token);

                      //void _getDataSource() {
                      //meetings = <Meeting>[];

                      //final DateTime today = DateTime.now();
                      int hora = dateChoosed.hour;
                      final DateTime startTime = DateTime(dateChoosed.year,
                          dateChoosed.month, dateChoosed.day, hora, 0, 0);
                      final DateTime endTime =
                          startTime.add(const Duration(hours: 1));
                      Meeting m = new Meeting('on', startTime, endTime,
                          const Color(0xFF0F8644), false);
                      debugPrint(m.eventName);
                      //setState(() {
                      meetings.add(m);
                      */
                      //});

                      //return meetings;
                      //}

                      // RoutesPatient().toCalendar(context);
                      RoutesGeneral().toPop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Future capture(MediaSource source) async {
    setState(() {
      this.source = source;
      fileMediaCarer = null;
    });

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SourcePage(),
        settings: RouteSettings(
          arguments: source,
        ),
      ),
    );

    if (result == null) {
      return;
    } else {
      setState(() {
        fileMediaCarer = result;
      });
    }
  }

  Future delete() async {
    setState(() {
      fileMediaCarer = null;
    });
  }

  Future save() async {}

  void onChangedStateValue(Object value) {
    setState(() {
      selectedStateRadio = value;
    });
  }

  void onChangedDyskinesiaValue(Object value) {
    setState(() {
      selectedDyskinesiaRadio = value;
    });
  }
}
