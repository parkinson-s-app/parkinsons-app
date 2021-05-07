import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ19 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ19 createState() => _NoMotorSymptomsFormQ19();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character19;
int selectedStateRadioQ19 = 0;

class _NoMotorSymptomsFormQ19 extends State<NoMotorSymptomsFormQ19> {
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
                "Dificultades en la relación sexual cuando lo intenta",
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
                groupValue: _character19,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character19 = value;
                    selectedStateRadioQ19 = 1;
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
                groupValue: _character19,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character19 = value;
                    selectedStateRadioQ19 = 0;
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

class BringAnswer19 {
  int send() {
    return selectedStateRadioQ19;
  }
}
class RestartQ19 {
  void setTile(){
    _character19 = SigningCharacter.Nada;
  }
}