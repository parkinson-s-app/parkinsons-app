import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ23 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ23 createState() => _NoMotorSymptomsFormQ23();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character23;
int selectedStateRadioQ23 = 0;

class _NoMotorSymptomsFormQ23 extends State<NoMotorSymptomsFormQ23> {
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
                "Dificultad para quedarse o mantenerse dormido por la noche",
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
                groupValue: _character23,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character23 = value;
                    selectedStateRadioQ23 = 1;
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
                groupValue: _character23,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character23 = value;
                    selectedStateRadioQ23 = 2;
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

class BringAnswer23 {
  int send() {
    return selectedStateRadioQ23;
  }
}
class RestartQ23 {
  void setTile(){
    _character23 = SigningCharacter.Nada;
  }
}