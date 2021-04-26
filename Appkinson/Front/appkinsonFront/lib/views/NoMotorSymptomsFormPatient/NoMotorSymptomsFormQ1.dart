import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ1 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ1 createState() => _NoMotorSymptomsFormQ1();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character1;
int selectedStateRadioQ1 = 0;

class _NoMotorSymptomsFormQ1 extends State<NoMotorSymptomsFormQ1> {
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
                "Salivación durante el día",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: "Ralewaybold",
                ),
              ),
            ),
          ),
          Divider(
                height: 10,
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
                groupValue: _character1,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character1 = value;
                    selectedStateRadioQ1 = 1;
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
                groupValue: _character1,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character1 = value;
                    selectedStateRadioQ1 = 2;
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

class BringAnswer1 {
  int send() {
    return selectedStateRadioQ1;
  }
}

class RestartQ1 {
  void setTile(){
    _character1 = SigningCharacter.Nada;
  }
}