import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ25 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ25 createState() => _NoMotorSymptomsFormQ25();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character25;
int selectedStateRadioQ25 = 0;

class _NoMotorSymptomsFormQ25 extends State<NoMotorSymptomsFormQ25> {
  void initState() {
    super.initState();
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
              alignment: Alignment.topCenter,
              child: Text(
                " Hablar o moverse durante el sueño como si lo estuviera viviendo",
                textAlign: TextAlign.justify,
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
                    fontSize: 30.0,
                  ),
                ),
                value: SigningCharacter.Si,
                groupValue: _character25,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character25 = value;
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
                    fontSize: 30.0,
                  ),
                ),
                value: SigningCharacter.No,
                groupValue: _character25,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character25 = value;
                    selectedStateRadioQ25 = 0;
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
class RestartQ25 {
  void setTile(){
    _character25 = SigningCharacter.Nada;
  }
}