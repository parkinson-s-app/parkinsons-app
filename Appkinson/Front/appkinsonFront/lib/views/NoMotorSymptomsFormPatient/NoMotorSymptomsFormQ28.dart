import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ28 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ28 createState() => _NoMotorSymptomsFormQ28();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character28;
int selectedStateRadioQ28 = 0;

class _NoMotorSymptomsFormQ28 extends State<NoMotorSymptomsFormQ28> {
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
                " Sudoración excesiva",
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
                groupValue: _character28,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character28 = value;
                    selectedStateRadioQ28 = 1;
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
                groupValue: _character28,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character28 = value;
                    selectedStateRadioQ28 = 0;
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

class BringAnswer28 {
  int send() {
    return selectedStateRadioQ28;
  }
}
class RestartQ28 {
  void setTile(){
    _character28 = SigningCharacter.Nada;
  }
}