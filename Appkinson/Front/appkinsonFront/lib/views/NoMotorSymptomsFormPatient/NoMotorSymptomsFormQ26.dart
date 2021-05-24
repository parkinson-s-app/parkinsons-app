import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ26 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ26 createState() => _NoMotorSymptomsFormQ26();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character26;
int selectedStateRadioQ26 = 0;

class _NoMotorSymptomsFormQ26 extends State<NoMotorSymptomsFormQ26> {
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
                "Sensaciones desagradables en las piernas por la noche o cuando está descansando, y sensación de que necesita moverlas",
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
                groupValue: _character26,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character26 = value;
                    selectedStateRadioQ26 = 1;
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
                groupValue: _character26,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character26 = value;
                    selectedStateRadioQ26 = 0;
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

class BringAnswer26 {
  int send() {
    return selectedStateRadioQ26;
  }
}
class RestartQ26 {
  void setTile(){
    _character26 = SigningCharacter.Nada;
  }
}