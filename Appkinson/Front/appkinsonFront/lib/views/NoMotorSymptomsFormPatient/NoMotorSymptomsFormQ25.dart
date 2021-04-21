import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ25 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ25 createState() => _NoMotorSymptomsFormQ25();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character;
int selectedStateRadioQ25 = 0;

class _NoMotorSymptomsFormQ25 extends State<NoMotorSymptomsFormQ25> {
  void initState() {
    super.initState();
    _character = SigningCharacter.Nada;
    selectedStateRadioQ25 = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[350],
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                " Hablar o moverse durante el sueño como si lo estuviera viviendo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: "Ralewaybold",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(children: <Widget>[
              Divider(
                height: 80,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'Si',
                  style: TextStyle(
                    fontSize: 35.0,
                  ),
                ),
                value: SigningCharacter.Si,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ25 = 1;
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
                    fontSize: 35.0,
                  ),
                ),
                value: SigningCharacter.No,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ25 = 2;
                  });
                },
              ),
              Divider(
                height: 80,
              ),
            ]),

            /*Expanded(
            flex: 1,
          */
          ),
        ],
      ),
    );
  }
}

class BringAnswer25 {
  int send() {
    return selectedStateRadioQ25;
  }
}
