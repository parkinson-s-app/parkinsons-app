import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ11 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ11 createState() => _NoMotorSymptomsFormQ11();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character11;
int selectedStateRadioQ11 = 0;

class _NoMotorSymptomsFormQ11 extends State<NoMotorSymptomsFormQ11> {
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
                "Cambio de peso sin causa aparente (no debido a un régimen o dieta",
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
                groupValue: _character11,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character11 = value;
                    selectedStateRadioQ11 = 1;
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
                groupValue: _character11,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character11 = value;
                    selectedStateRadioQ11 = 2;
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

class BringAnswer11 {
  int send() {
    return selectedStateRadioQ11;
  }
}
class RestartQ11 {
  void setTile(){
    _character11 = SigningCharacter.Nada;
  }
}