import 'dart:io';
import 'package:appkinsonFront/views/SymptomsForm/videoPluguin.dart';
import 'package:flutter/material.dart';

class SymptomsFormPatientQ4 extends StatefulWidget {
  @override
  _symptomsFormPatientQ4 createState() => _symptomsFormPatientQ4();
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

class _symptomsFormPatientQ4 extends State<SymptomsFormPatientQ4> {
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
                "TIENE DISQUINESIAS...",
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
                  title: const Text('Severas'),
                  value: SigningCharacter.Normal,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    debugPrint(BringAnswerPatientQ4().send().toString());
                    setState(() {
                      _character = value;
                      selectedStateRadioQ1 = 'Severas';
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Leves'),
                  value: SigningCharacter.PerdidaDeExpresion,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    debugPrint(BringAnswerPatientQ4().send().toString());
                    setState(() {
                      _character = value;
                      selectedStateRadioQ1 = 'Leves';
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Indistinguible'),
                  value: SigningCharacter.Monotono,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    debugPrint(BringAnswerPatientQ4().send().toString());
                    setState(() {
                      _character = value;
                      selectedStateRadioQ1 = 'Indistinguible';
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

class BringAnswerPatientQ4 {
  String send() {
    return selectedStateRadioQ1;
  }
}
