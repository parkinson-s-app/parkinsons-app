import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ16 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ16 createState() => _NoMotorSymptomsFormQ16();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character16;
int selectedStateRadioQ16 = 0;

class _NoMotorSymptomsFormQ16 extends State<NoMotorSymptomsFormQ16> {
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
                "Sentirse triste, bajo/a de ánimo o decaído",
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
                groupValue: _character16,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character16 = value;
                    selectedStateRadioQ16 = 1;
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
                groupValue: _character16,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character16 = value;
                    selectedStateRadioQ16 = 0;
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

class BringAnswer16 {
  int send() {
    return selectedStateRadioQ16;
  }
}
class RestartQ16 {
  void setTile(){
    _character16 = SigningCharacter.Nada;
  }
}