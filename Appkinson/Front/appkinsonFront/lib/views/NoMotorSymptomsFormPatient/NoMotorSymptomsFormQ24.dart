import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ24 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ24 createState() => _NoMotorSymptomsFormQ24();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character24;
int selectedStateRadioQ24 = 0;

class _NoMotorSymptomsFormQ24 extends State<NoMotorSymptomsFormQ24> {
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
                "Sueños intensos, vívidos o pesadillas.",
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
                groupValue: _character24,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character24 = value;
                    selectedStateRadioQ24 = 1;
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
                groupValue: _character24,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character24 = value;
                    selectedStateRadioQ24 = 2;
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

class BringAnswer24 {
  int send() {
    return selectedStateRadioQ24;
  }
}
class RestartQ24 {
  void setTile(){
    _character24 = SigningCharacter.Nada;
  }
}