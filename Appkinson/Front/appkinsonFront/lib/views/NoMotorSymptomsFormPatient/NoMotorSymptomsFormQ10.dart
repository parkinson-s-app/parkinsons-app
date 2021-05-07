import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ10 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ10 createState() => _NoMotorSymptomsFormQ10();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character10;
int selectedStateRadioQ10 = 0;

class _NoMotorSymptomsFormQ10 extends State<NoMotorSymptomsFormQ10> {
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
                "Dolores sin causa aparente (no debidos a otras enfermedades, como la artrosis)",
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
                groupValue: _character10,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character10 = value;
                    selectedStateRadioQ10 = 1;
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
                groupValue: _character10,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character10 = value;
                    selectedStateRadioQ10 = 0;
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

class BringAnswer10 {
  int send() {
    return selectedStateRadioQ10;
  }
}
class RestartQ10 {
  void setTile(){
    _character10 = SigningCharacter.Nada;
  }
}