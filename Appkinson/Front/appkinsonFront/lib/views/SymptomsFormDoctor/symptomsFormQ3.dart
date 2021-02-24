import 'package:flutter/material.dart';

class symptomsFormQ3 extends StatefulWidget {
  @override
  _symptomsFormQ3 createState() => _symptomsFormQ3();
}

enum SigningCharacter { Ausente, Infrecuente, Persistente, Mayoria, Presente }
SigningCharacter _character;
int selectedStateRadioQ3 = 0;

class _symptomsFormQ3 extends State<symptomsFormQ3> {
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
                "RIGIDEZ",
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
                  title: const Text('0: Normal   Sin rigidez. '),
                  value: SigningCharacter.Ausente,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ3 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('1: Mínimo   Rigidez solo detectable con maniobra de activación.'),
                  value: SigningCharacter.Infrecuente,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ3 = 1;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('2: Leve   La rigidez se detecta sin maniobra de activación, pero se consigue fácilmente el rango completo de movimiento.'),
                  value: SigningCharacter.Persistente,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ3 = 2;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('3: Moderado   La rigidez se detecta sin maniobra de activación; se consigue el rango de movimiento completo con esfuerzo.'),
                  value: SigningCharacter.Mayoria,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ3 = 3;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('4:   Grave La rigidez se detecta sin maniobra de activación y no se consigue el rango completo de movimiento.'),
                  value: SigningCharacter.Presente,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ3 = 4;
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

class BringAnswer3 {
  int send() {
    return selectedStateRadioQ3;
  }
}
