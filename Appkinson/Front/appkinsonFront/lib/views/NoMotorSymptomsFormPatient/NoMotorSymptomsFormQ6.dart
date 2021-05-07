import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ6 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ6 createState() => _NoMotorSymptomsFormQ6();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character6;
int selectedStateRadioQ6 = 0;

class _NoMotorSymptomsFormQ6 extends State<NoMotorSymptomsFormQ6> {
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
                "Incontinencia fecal (se escapan las heces)",
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
                groupValue: _character6,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character6 = value;
                    selectedStateRadioQ6 = 1;
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
                groupValue: _character6,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character6 = value;
                    selectedStateRadioQ6 = 0;
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

class BringAnswer6 {
  int send() {
    return selectedStateRadioQ6;
  }
}
class RestartQ6 {
  void setTile(){
    _character6 = SigningCharacter.Nada;
  }
}