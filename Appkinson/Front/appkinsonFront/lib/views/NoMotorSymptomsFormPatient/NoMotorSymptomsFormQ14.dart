import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ14 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ14 createState() => _NoMotorSymptomsFormQ14();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character14;
int selectedStateRadioQ14 = 0;

class _NoMotorSymptomsFormQ14 extends State<NoMotorSymptomsFormQ14> {
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
                "Ver u oír cosas que sabe o que otras personas le dicen que no están ahí",
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
                groupValue: _character14,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character14 = value;
                    selectedStateRadioQ14 = 1;
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
                groupValue: _character14,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character14 = value;
                    selectedStateRadioQ14 = 0;
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

class BringAnswer14 {
  int send() {
    return selectedStateRadioQ14;
  }
}
class RestartQ14 {
  void setTile(){
    _character14 = SigningCharacter.Nada;
  }
}