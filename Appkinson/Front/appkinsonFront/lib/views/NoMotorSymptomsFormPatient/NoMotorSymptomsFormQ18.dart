import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ18 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ18 createState() => _NoMotorSymptomsFormQ18();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character;
int selectedStateRadioQ18 = 0;

class _NoMotorSymptomsFormQ18 extends State<NoMotorSymptomsFormQ18> {
  void initState() {
    super.initState();
    _character = SigningCharacter.Nada;
    selectedStateRadioQ18 = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white60,
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                "Pérdida o aumento del interés por tener relaciones sexuales",
                style: TextStyle(
                  fontSize: 22.0,
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
                    fontSize: 40.0,
                  ),
                ),
                value: SigningCharacter.Si,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ18 = 1;
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
                    fontSize: 40.0,
                  ),
                ),
                value: SigningCharacter.No,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ18 = 2;
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

class BringAnswer18 {
  int send() {
    return selectedStateRadioQ18;
  }
}
