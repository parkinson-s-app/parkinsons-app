import 'package:flutter/material.dart';

class EmotionalFormQ1 extends StatefulWidget {
  @override
  _EmotionalFormQ1 createState() => _EmotionalFormQ1();
}

enum SigningCharacter { Si, No }
SigningCharacter _character;
int selectedStateRadioQ1 = -1;

class _EmotionalFormQ1 extends State<EmotionalFormQ1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white60,
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                "Poco interés o placer en hacer cosas",
                style: TextStyle(
                  fontSize: 22.0,
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
                  'Ningún día',
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                value: SigningCharacter.Si,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ1 = 0;
                  });
                },
              ),
              Divider(
                height: 100,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'Varios días',
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                value: SigningCharacter.No,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ1 = 1;
                  });
                },
              ),
              Divider(
                height: 80,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'Más de la mitad de los días',
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                value: SigningCharacter.No,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ1 = 2;
                  });
                },
              ),
              Divider(
                height: 80,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'Casi todos los días',
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                value: SigningCharacter.No,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ1 = 3;
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

class BringAnswer1 {
  int send() {
    return selectedStateRadioQ1;
  }
}
