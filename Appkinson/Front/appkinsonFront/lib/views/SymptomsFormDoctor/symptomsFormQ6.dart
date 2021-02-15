import 'package:flutter/material.dart';

class symptomsFormQ6 extends StatefulWidget {
  @override
  _symptomsFormQ6 createState() => _symptomsFormQ6();
}

enum SigningCharacter { Ausente, Discreto, Moderada, Intensa, MuyIntensa }
SigningCharacter _character;
int selectedStateRadioQ6 = 0;

class _symptomsFormQ6 extends State<symptomsFormQ6> {
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
                "RIGIDEZ GRANDES ARTICULACIONES RELAJADO Y SENTADO",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "Ralewaybold",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                RadioListTile<SigningCharacter>(
                  title: const Text('Ausente'),
                  value: SigningCharacter.Ausente,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ6 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text(
                      'Discreto, detectable solamente cuando hay sacudidas involuntarias'),
                  value: SigningCharacter.Discreto,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ6 = 1;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Discreto a moderado'),
                  value: SigningCharacter.Moderada,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ6 = 2;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text(
                      'Intensa pero no impide movimientos en toda su amplitud'),
                  value: SigningCharacter.Intensa,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ6 = 3;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text(
                      'Muy intensa, dificulta movimientos en toda su amplitud'),
                  value: SigningCharacter.MuyIntensa,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ6 = 4;
                    });
                  },
                ),
              ],
            ),
          ),
          /*Expanded(
            flex: 1,
          ),*/
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
