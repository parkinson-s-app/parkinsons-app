import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ7 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ7 createState() => _NoMotorSymptomsFormQ7();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character7;
int selectedStateRadioQ7 = 0;

class _NoMotorSymptomsFormQ7 extends State<NoMotorSymptomsFormQ7> {
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
                "Sensación de no haber vaciado por completo el vientre después de ir al baño",
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
                groupValue: _character7,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character7 = value;
                    selectedStateRadioQ7 = 1;
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
                groupValue: _character7,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character7 = value;
                    selectedStateRadioQ7 = 2;
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

class BringAnswer7 {
  int send() {
    return selectedStateRadioQ7;
  }
}
class RestartQ7 {
  void setTile(){
    _character7 = SigningCharacter.Nada;
  }
}