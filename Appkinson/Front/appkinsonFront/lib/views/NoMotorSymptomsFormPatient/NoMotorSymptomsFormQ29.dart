import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ29 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ29 createState() => _NoMotorSymptomsFormQ29();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character29;
int selectedStateRadioQ29 = 0;

class _NoMotorSymptomsFormQ29 extends State<NoMotorSymptomsFormQ29> {
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
                "Visión doble",
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
                groupValue: _character29,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character29 = value;
                    selectedStateRadioQ29 = 1;
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
                groupValue: _character29,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character29 = value;
                    selectedStateRadioQ29 = 2;
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

class BringAnswer29 {
  int send() {
    return selectedStateRadioQ29;
  }
}
class RestartQ29 {
  void setTile(){
    _character29 = SigningCharacter.Nada;
  }
}