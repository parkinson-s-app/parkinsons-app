import 'dart:io';
import 'package:appkinsonFront/views/SymptomsForm/videoPluguin.dart';
import 'package:flutter/material.dart';

class SymptomsFormPatientQ2 extends StatefulWidget {
  @override
  _symptomsFormPatientQ2 createState() => _symptomsFormPatientQ2();
}

enum SigningCharacter {
  Normal,
  PerdidaDeExpresion,
  Monotono,
  Alterado,
  Ininteligible
}
SigningCharacter _character = SigningCharacter.Normal;
String selectedStateRadioQ1 = null;

class _symptomsFormPatientQ2 extends State<SymptomsFormPatientQ2> {
  @override
  Widget build(BuildContext context) {
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
                "ESTA EN ESTADO ON,OFF o Durmiendo?",
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "Ralewaybold",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                RadioListTile<SigningCharacter>(
                  title: const Text('OFF'),
                  value: SigningCharacter.Normal,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    debugPrint(BringAnswerPatient2().send().toString());
                    setState(() {
                      _character = value;
                      selectedStateRadioQ1 = 'OFF';
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('ON'),
                  value: SigningCharacter.PerdidaDeExpresion,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    debugPrint(BringAnswerPatient2().send().toString());
                    setState(() {
                      _character = value;
                      selectedStateRadioQ1 = 'ON';
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Durmiendo'),
                  value: SigningCharacter.Monotono,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    debugPrint(BringAnswerPatient2().send().toString());
                    setState(() {
                      _character = value;
                      selectedStateRadioQ1 = 'Durmiendo';
                    });
                  },
                ),
              ],
            ),
          ),
          /*Expanded(
            flex: 1,
          ),*/
        ],
      ),
    );
  }
}

class BringAnswerPatient2 {
  String send() {
    return selectedStateRadioQ1;
  }
}
