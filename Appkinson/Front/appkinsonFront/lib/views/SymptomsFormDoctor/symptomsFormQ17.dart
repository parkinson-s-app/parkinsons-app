import 'package:flutter/material.dart';

class symptomsFormQ17 extends StatefulWidget {
  @override
  _symptomsFormQ17 createState() => _symptomsFormQ17();
}

enum SigningCharacter { Ausente, Infrecuente, Persistente, Mayoria, Presente }
SigningCharacter _character;
int selectedStateRadioQ17 = 0;

class _symptomsFormQ17 extends State<symptomsFormQ17> {
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
                "TEMBLOR DE REPOSO EN MIEMBROS SUPERIORES",
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
                      selectedStateRadioQ17 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Poca frecuencia'),
                  value: SigningCharacter.Infrecuente,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ17 = 1;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Persistente'),
                  value: SigningCharacter.Persistente,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ17 = 2;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text(
                      'Presente la mayor parte del tiempo, temblor moderado'),
                  value: SigningCharacter.Mayoria,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ17 = 3;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text(
                      'Presente la mayor parte del tiempo, temblor severo'),
                  value: SigningCharacter.Presente,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ17 = 4;
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

class BringAnswer17 {
  Future<int> send() async {
    return selectedStateRadioQ17;
  }
}
