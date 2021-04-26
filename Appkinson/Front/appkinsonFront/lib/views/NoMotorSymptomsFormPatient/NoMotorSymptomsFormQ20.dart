import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ20 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ20 createState() => _NoMotorSymptomsFormQ20();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character20;
int selectedStateRadioQ20 = 0;

class _NoMotorSymptomsFormQ20 extends State<NoMotorSymptomsFormQ20> {
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
                "Sensación de mareo o debilidad al ponerse de pie después de haber estado sentado o acostado",
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
                groupValue: _character20,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character20 = value;
                    selectedStateRadioQ20 = 1;
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
                groupValue: _character20,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character20 = value;
                    selectedStateRadioQ20 = 2;
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

class BringAnswer20 {
  int send() {
    return selectedStateRadioQ20;
  }
}
class RestartQ20 {
  void setTile(){
    _character20 = SigningCharacter.Nada;
  }
}