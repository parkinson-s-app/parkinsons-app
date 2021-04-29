import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ13 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ13 createState() => _NoMotorSymptomsFormQ13();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character13;
int selectedStateRadioQ13 = 0;

class _NoMotorSymptomsFormQ13 extends State<NoMotorSymptomsFormQ13> {
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
                "Pérdida de interés en lo que pasa a su alrededor o en realizar sus actividades",
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
                groupValue: _character13,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character13 = value;
                    selectedStateRadioQ13 = 1;
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
                groupValue: _character13,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character13 = value;
                    selectedStateRadioQ13 = 2;
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

class BringAnswer13 {
  int send() {
    return selectedStateRadioQ13;
  }
}
class RestartQ13 {
  void setTile(){
    _character13 = SigningCharacter.Nada;
  }
}