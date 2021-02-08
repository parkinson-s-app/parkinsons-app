import 'dart:io';
import 'package:appkinsonFront/views/Calendar/CalendarScreenView2.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ1.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ2.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ2OFF.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ3.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ4.dart';
import 'package:appkinsonFront/model/SymptomsFormPatientM.dart';
import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Calendar/CalendarScreen.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:appkinsonFront/views/SymptomsFormDoctor/videoPluguin.dart';

import 'package:flutter/material.dart';

class SymptomsFormPatientQ5OFF extends StatefulWidget {
  @override
  _symptomsFormQ29 createState() => _symptomsFormQ29();
}

class _symptomsFormQ29 extends State<SymptomsFormPatientQ5OFF> {
  File fileMedia;
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
                  child: fileMedia == null
                      ? Icon(Icons.play_circle_outline, size: 240)
                      : (source == MediaSource.image
                          ? Image.file(fileMedia)
                          : VideoWidget(fileMedia)),
                ),
                const SizedBox(height: 24),
                RaisedButton(
                  child: Text('Capturar video'),
                  shape: StadiumBorder(),
                  onPressed: () => capture(MediaSource.video),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 12),
                RaisedButton(
                  child: Text('Eliminar video'),
                  shape: StadiumBorder(),
                  onPressed: () => delete(),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 12),
                RaisedButton(
                  child: Text('Guardar registro'),
                  shape: StadiumBorder(),
                  //onPressed: () => save(),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () async {
                    SymptomsFormPatientM patientForm =
                        new SymptomsFormPatientM();

                    patientForm.q1 = BringAnswerPatient1().send();
                    patientForm.q2 = BringAnswerPatient2().send();
                    patientForm.q3 = BringAnswer2Off().send();
                    patientForm.q4 = BringAnswerPatientQ3().send();
                    patientForm.q5 = BringAnswerPatientQ4().send();
                    patientForm.video = fileMedia;
                    patientForm.formDate = dateChoosed;

                    debugPrint('enviado');
                    var savedDone = await EndPoints()
                        .registerSymptomsFormPatient(
                            patientForm, currentUser['id'].toString(), token);

                    debugPrint(savedDone.toString());

                    int hora = dateChoosed.hour;

                    final DateTime startTime = DateTime(dateChoosed.year,
                        dateChoosed.month, dateChoosed.day, hora, 0, 0);
                    final DateTime endTime =
                        startTime.add(const Duration(hours: 1));
                    Meeting m = new Meeting(
                        'off', startTime, endTime, Colors.red, false);
                    debugPrint(m.eventName);
                    //setState(() {
                    meetings.add(m);

                    RoutesPatient().toCalendar(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );

  Future capture(MediaSource source) async {
    setState(() {
      this.source = source;
      this.fileMedia = null;
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
        fileMedia = result;
      });
    }
  }

  Future delete() async {
    setState(() {
      this.fileMedia = null;
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
