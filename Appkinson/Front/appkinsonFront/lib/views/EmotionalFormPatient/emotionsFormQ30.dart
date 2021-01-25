import 'dart:io';
import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:flutter/material.dart';
import '../../model/EmotionsForm.dart';
import 'emotionsFormQ1.dart';
import 'emotionsFormQ2.dart';
import 'emotionsFormQ3.dart';
import 'emotionsFormQ4.dart';
import 'emotionsFormQ5.dart';
import 'emotionsFormQ6.dart';
import 'emotionsFormQ7.dart';
import 'emotionsFormQ8.dart';
import 'emotionsFormQ9.dart';
import 'emotionsFormQ10.dart';
import 'emotionsFormQ11.dart';
import 'emotionsFormQ12.dart';
import 'emotionsFormQ13.dart';
import 'emotionsFormQ14.dart';
import 'emotionsFormQ15.dart';
import 'emotionsFormQ16.dart';
import 'emotionsFormQ17.dart';
import 'emotionsFormQ18.dart';
import 'emotionsFormQ19.dart';
import 'emotionsFormQ20.dart';
import 'emotionsFormQ21.dart';
import 'emotionsFormQ22.dart';
import 'emotionsFormQ23.dart';
import 'emotionsFormQ24.dart';
import 'emotionsFormQ25.dart';
import 'emotionsFormQ26.dart';
import 'emotionsFormQ27.dart';
import 'emotionsFormQ28.dart';
import 'emotionsFormQ29.dart';

class emotionsFormQ30 extends StatefulWidget {
  @override
  _emotionsFormQ30 createState() => _emotionsFormQ30();
}

enum SigningCharacter {Si, No}
SigningCharacter _character;
int selectedStateRadioQ30 = 0;

class _emotionsFormQ30 extends State<emotionsFormQ30> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white60,
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                "Creer que le pasan cosas que otras personas le dicen que no son verdad.",
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "Ralewaybold",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
                children: <Widget>[
                  Divider(
                    height: 80,
                  ),
                  RadioListTile<SigningCharacter>(
                    title: const Text(
                      'Si',
                      style: TextStyle(
                        fontSize: 40.0,
                      ),
                    ),
                    value: SigningCharacter.Si,
                    groupValue: _character,
                    onChanged: (SigningCharacter value){
                      setState(() {
                        _character = value;
                        selectedStateRadioQ30 = 1;
                      });
                    },
                  ),
                  Divider(
                    height: 100,
                  ),
                  RadioListTile<SigningCharacter>(
                    title: const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 40.0,
                      ),
                    ),
                    value: SigningCharacter.No,
                    groupValue: _character,
                    onChanged: (SigningCharacter value){
                      setState(() {
                        _character = value;
                        selectedStateRadioQ30 = 2;
                      });
                    },
                  ),
                  Divider(
                    height: 50,
                  ),
                  RaisedButton(
                    child: Text("Guardar registro", style: TextStyle(fontSize: 20)),
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    //onPressed: () => save(),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      EmotionsForm patientForm = new EmotionsForm();
                      patientForm.q1 = BringAnswer1().send();
                      patientForm.q2 = BringAnswer2().send();
                      patientForm.q3 = BringAnswer3().send();
                      patientForm.q4 = BringAnswer4().send();
                      patientForm.q5 = BringAnswer5().send();
                      patientForm.q6 = BringAnswer6().send();
                      patientForm.q7 = BringAnswer7().send();
                      patientForm.q8 = BringAnswer8().send();
                      patientForm.q9 = BringAnswer9().send();
                      patientForm.q10 = BringAnswer10().send();
                      patientForm.q11 = BringAnswer11().send();
                      patientForm.q12 = BringAnswer12().send();
                      patientForm.q13 = BringAnswer13().send();
                      patientForm.q14 = BringAnswer14().send();
                      patientForm.q15 = BringAnswer15().send();
                      patientForm.q16 = BringAnswer16().send();
                      patientForm.q17 = BringAnswer17().send();
                      patientForm.q18 = BringAnswer18().send();
                      patientForm.q19 = BringAnswer19().send();
                      patientForm.q20 = BringAnswer20().send();
                      patientForm.q21 = BringAnswer21().send();
                      patientForm.q22 = BringAnswer22().send();
                      patientForm.q23 = BringAnswer23().send();
                      patientForm.q24 = BringAnswer24().send();
                      patientForm.q25 = BringAnswer25().send();
                      patientForm.q26 = BringAnswer26().send();
                      patientForm.q27 = BringAnswer27().send();
                      patientForm.q28 = BringAnswer28().send();
                      patientForm.q29 = BringAnswer29().send();
                      patientForm.q30 = BringAnswer30().send();
                      patientForm.date = null;
                      /*var savedDone = await EndPoints().registerSymptomsForm(
                          patientForm, currentUser['id'].toString(), token);*/

                      RoutesGeneral().toPop(context);
                    },
                  ),
                ]
            ),

            /*Expanded(
            flex: 1,
          */),
        ],
      ),
    );
  }
}

class BringAnswer30 {
  int send() {
    return selectedStateRadioQ30;
  }
}