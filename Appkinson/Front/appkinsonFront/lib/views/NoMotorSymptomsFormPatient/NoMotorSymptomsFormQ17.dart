import 'package:flutter/material.dart';

class NoMotorSymptomsFormQ17 extends StatefulWidget {
  @override
  _NoMotorSymptomsFormQ17 createState() => _NoMotorSymptomsFormQ17();
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character17;
int selectedStateRadioQ17 = 0;

class _NoMotorSymptomsFormQ17 extends State<NoMotorSymptomsFormQ17> {
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
                "Sentimientos de ansiedad, miedo o pánico",
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
                groupValue: _character17,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character17 = value;
                    selectedStateRadioQ17 = 1;
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
                groupValue: _character17,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character17 = value;
                    selectedStateRadioQ17 = 2;
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

class BringAnswer17 {
  int send() {
    return selectedStateRadioQ17;
  }
}
class RestartQ17 {
  void setTile(){
    _character17 = SigningCharacter.Nada;
  }
}