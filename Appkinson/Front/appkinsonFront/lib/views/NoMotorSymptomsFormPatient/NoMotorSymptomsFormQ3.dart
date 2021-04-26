import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ3 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ3 createState() => _NoMotorSymptomsFormQ3();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character3;
int selectedStateRadioQ3 = 0;

class _NoMotorSymptomsFormQ3 extends State<NoMotorSymptomsFormQ3> {
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
                "Dificultad para pasar o deglutir comida o bebidas, o tendencia a atorarse ",
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
                groupValue: _character3,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character3 = value;
                    selectedStateRadioQ3 = 1;
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
                groupValue: _character3,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character3 = value;
                    selectedStateRadioQ3 = 2;
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

class BringAnswer3 {
  int send() {
    return selectedStateRadioQ3;
  }
}

class RestartQ3 {
  void setTile(){
    _character3 = SigningCharacter.Nada;
  }
}