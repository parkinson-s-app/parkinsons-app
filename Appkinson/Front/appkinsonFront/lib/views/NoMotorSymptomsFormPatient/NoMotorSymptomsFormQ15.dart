import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ15 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ15 createState() => _NoMotorSymptomsFormQ15();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character15;
int selectedStateRadioQ15 = 0;

class _NoMotorSymptomsFormQ15 extends State<NoMotorSymptomsFormQ15> {
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
                "Dificultad para concentrarse o mantener la atención",
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
                groupValue: _character15,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character15 = value;
                    selectedStateRadioQ15 = 1;
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
                groupValue: _character15,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character15 = value;
                    selectedStateRadioQ15 = 2;
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

class BringAnswer15 {
  int send() {
    return selectedStateRadioQ15;
  }
}
class RestartQ15 {
  void setTile(){
    _character15 = SigningCharacter.Nada;
  }
}