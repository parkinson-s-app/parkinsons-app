import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ5 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ5 createState() => _NoMotorSymptomsFormQ5();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character5;
int selectedStateRadioQ5 = 0;

class _NoMotorSymptomsFormQ5 extends State<NoMotorSymptomsFormQ5> {
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
                "Estreñimiento (hacer del cuerpo de 3 veces a la semana) o tener que hacer esfuerzos para hacer de vientre",
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
                groupValue: _character5,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character5 = value;
                    selectedStateRadioQ5 = 1;
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
                groupValue: _character5,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character5 = value;
                    selectedStateRadioQ5 = 2;
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

class BringAnswer5 {
  int send() {
    return selectedStateRadioQ5;
  }
}
class RestartQ5 {
  void setTile(){
    _character5 = SigningCharacter.Nada;
  }
}