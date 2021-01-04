import 'dart:io';
import '../SymptomsForm/videoPluguin.dart';
import 'package:flutter/material.dart';
import '../../services/EndPoints.dart';
import '../../model/SymptomsForm.dart';
import '../Login/Buttons/ButtonLogin.dart';
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
import '../Calendar/CalendarScreen.dart';

class symptomsFormQ29 extends StatefulWidget {
  @override
  _symptomsFormQ29 createState() => _symptomsFormQ29();
}

class _symptomsFormQ29 extends State<symptomsFormQ29> {
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
              onPressed: () async{
                SymptomsForm patientForm = new SymptomsForm();
                patientForm.q1 = BringAnswer1().send() as int;
                patientForm.q2 = BringAnswer2().send() as int;
                patientForm.q3 = BringAnswer3().send() as int;
                patientForm.q4 = BringAnswer4().send() as int;
                patientForm.q5 = BringAnswer5().send() as int;
                patientForm.q6 = BringAnswer6().send() as int;
                patientForm.q7 = BringAnswer7().send() as int;
                patientForm.q8 = BringAnswer8().send() as int;
                patientForm.q9 = BringAnswer9().send() as int;
                patientForm.q10 = BringAnswer10().send() as int;
                patientForm.q11 = BringAnswer11().send() as int;
                patientForm.q12 = BringAnswer12().send() as int;
                patientForm.q13 = BringAnswer13().send() as int;
                patientForm.q14 = BringAnswer14().send() as int;
                patientForm.q15 = BringAnswer15().send() as int;
                patientForm.q16 = BringAnswer16().send() as int;
                patientForm.video = fileMedia;
                patientForm.date = tempDate;
                var savedDone = await EndPoints().registerSymptomsForm(patientForm, currentUser['id'].toString(), token);
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

  Future save() async{

  }

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