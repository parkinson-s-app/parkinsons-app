import 'package:flutter/material.dart';

class SymptomsFormPatientQ3 extends StatefulWidget {
  @override
  _symptomsFormPatientQ3 createState() => _symptomsFormPatientQ3();
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

class _symptomsFormPatientQ3 extends State<SymptomsFormPatientQ3> {
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
                "CREE QUE EL MEDICAMENTO TIENE EFECTO?",
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
                  title: const Text('SI'),
                  value: SigningCharacter.Normal,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    debugPrint(BringAnswerPatientQ3().send().toString());
                    setState(() {
                      _character = value;
                      selectedStateRadioQ1 = 'SI';
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('NO'),
                  value: SigningCharacter.PerdidaDeExpresion,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    debugPrint(BringAnswerPatientQ3().send().toString());
                    setState(() {
                      _character = value;
                      selectedStateRadioQ1 = 'NO';
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

class BringAnswerPatientQ3 {
  String send() {
    return selectedStateRadioQ1;
  }
}
