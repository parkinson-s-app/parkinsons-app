import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ12 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ12 createState() => _NoMotorSymptomsFormQ12();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character12;
int selectedStateRadioQ12 = 0;

class _NoMotorSymptomsFormQ12 extends State<NoMotorSymptomsFormQ12> {
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
                "Problemas para recordar cosas que han pasado recientemente o dificultad para acordarse de cosas que tenía que hacer",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 28.0,
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
                groupValue: _character12,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character12 = value;
                    selectedStateRadioQ12 = 0;
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
                groupValue: _character12,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character12 = value;
                    selectedStateRadioQ12 = 2;
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

class BringAnswer12 {
  int send() {
    return selectedStateRadioQ12;
  }
}
class RestartQ12 {
  void setTile(){
    _character12 = SigningCharacter.Nada;
  }
}