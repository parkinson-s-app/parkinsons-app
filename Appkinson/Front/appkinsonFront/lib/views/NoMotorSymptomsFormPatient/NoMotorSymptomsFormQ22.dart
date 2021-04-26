import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ22 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ22 createState() => _NoMotorSymptomsFormQ22();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character22;
int selectedStateRadioQ22 = 0;

class _NoMotorSymptomsFormQ22 extends State<NoMotorSymptomsFormQ22> {
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
                "Dificultad para mantenerse despierto/a mientras realiza actividades como trabajar, conducir o comer",
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
                groupValue: _character22,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character22 = value;
                    selectedStateRadioQ22 = 1;
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
                groupValue: _character22,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character22 = value;
                    selectedStateRadioQ22 = 2;
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

class BringAnswer22 {
  int send() {
    return selectedStateRadioQ22;
  }
}
class RestartQ22 {
  void setTile(){
    _character22 = SigningCharacter.Nada;
  }
}