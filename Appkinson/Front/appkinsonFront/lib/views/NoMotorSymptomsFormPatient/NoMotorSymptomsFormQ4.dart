import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ4 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ4 createState() => _NoMotorSymptomsFormQ4();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character4;
int selectedStateRadioQ4 = 0;

class _NoMotorSymptomsFormQ4 extends State<NoMotorSymptomsFormQ4> {
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
                "Vómitos o náuseas",
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
                groupValue: _character4,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character4 = value;
                    selectedStateRadioQ4 = 1;
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
                groupValue: _character4,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character4 = value;
                    selectedStateRadioQ4 = 2;
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

class BringAnswer4 {
  int send() {
    return selectedStateRadioQ4;
  }
}
class RestartQ4 {
  void setTile(){
    _character4 = SigningCharacter.Nada;
  }
}