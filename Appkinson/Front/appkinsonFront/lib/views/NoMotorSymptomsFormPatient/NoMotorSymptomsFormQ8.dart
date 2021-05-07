import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ8 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ8 createState() => _NoMotorSymptomsFormQ8();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character8;
int selectedStateRadioQ8 = 0;

class _NoMotorSymptomsFormQ8 extends State<NoMotorSymptomsFormQ8> {
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
                "Sensación de tener que orinar urgentemente que le obliga a ir rápidamente al baño",
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
                groupValue: _character8,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character8 = value;
                    selectedStateRadioQ8 = 1;
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
                groupValue: _character8,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character8 = value;
                    selectedStateRadioQ8 = 0;
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

class BringAnswer8 {
  int send() {
    return selectedStateRadioQ8;
  }
}
class RestartQ8 {
  void setTile(){
    _character8 = SigningCharacter.Nada;
  }
}