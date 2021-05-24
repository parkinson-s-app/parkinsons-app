import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ27 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ27 createState() => _NoMotorSymptomsFormQ27();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character27;
int selectedStateRadioQ27 = 0;

class _NoMotorSymptomsFormQ27 extends State<NoMotorSymptomsFormQ27> {
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
                "Hinchazón en las piernas.",
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
                groupValue: _character27,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character27 = value;
                    selectedStateRadioQ27 = 1;
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
                groupValue: _character27,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character27 = value;
                    selectedStateRadioQ27 = 0;
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

class BringAnswer27 {
  int send() {
    return selectedStateRadioQ27;
  }
}
class RestartQ27 {
  void setTile(){
    _character27 = SigningCharacter.Nada;
  }
}