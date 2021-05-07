import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ9 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ9 createState() => _NoMotorSymptomsFormQ9();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character9;
int selectedStateRadioQ9 = 0;

class _NoMotorSymptomsFormQ9 extends State<NoMotorSymptomsFormQ9> {
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
                "Necesidad de levantarse habitualmente por la noche a orinar",
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
                groupValue: _character9,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character9 = value;
                    selectedStateRadioQ9 = 1;
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
                groupValue: _character9,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character9 = value;
                    selectedStateRadioQ9 = 0;
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

class BringAnswer9 {
  int send() {
    return selectedStateRadioQ9;
  }
}
class RestartQ9 {
  void setTile(){
    _character9 = SigningCharacter.Nada;
  }
}