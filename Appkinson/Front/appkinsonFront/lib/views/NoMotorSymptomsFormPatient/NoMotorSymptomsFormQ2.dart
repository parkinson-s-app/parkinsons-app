import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ2 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ2 createState() => _NoMotorSymptomsFormQ2();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character2;
int selectedStateRadioQ2 = 0;

class _NoMotorSymptomsFormQ2 extends State<NoMotorSymptomsFormQ2> {
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
              alignment: Alignment.center,
              child: Text(
                "Pérdida o alteración en la percepción de sabores u olores ",
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
                    fontSize: 30.0,
                  ),
                ),
                value: SigningCharacter.Si,
                groupValue: _character2,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character2 = value;
                    selectedStateRadioQ2 = 1;
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
                groupValue: _character2,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character2 = value;
                    selectedStateRadioQ2 = 2;
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

class BringAnswer2 {
  int send() {
    return selectedStateRadioQ2;
  }
}

class RestartQ2 {
  void setTile(){
    _character2 = SigningCharacter.Nada;
  }
}