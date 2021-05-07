import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ21 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ21 createState() => _NoMotorSymptomsFormQ21();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character21;
int selectedStateRadioQ21 = 0;

class _NoMotorSymptomsFormQ21 extends State<NoMotorSymptomsFormQ21> {
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
                "Caídas",
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
                groupValue: _character21,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character21 = value;
                    selectedStateRadioQ21 = 1;
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
                groupValue: _character21,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character21 = value;
                    selectedStateRadioQ21 = 0;
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

class BringAnswer21 {
  int send() {
    return selectedStateRadioQ21;
  }
}
class RestartQ21 {
  void setTile(){
    _character21 = SigningCharacter.Nada;
  }
}