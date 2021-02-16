import 'package:flutter/material.dart';

class symptomsFormQ12 extends StatefulWidget {
  @override
  _symptomsFormQ12 createState() => _symptomsFormQ12();
}

enum SigningCharacter { Normal, Enlentecimiento, Moderado, Alterado, Dificil }
SigningCharacter _character;
int selectedStateRadioQ12 = 0;

class _symptomsFormQ12 extends State<symptomsFormQ12> {
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
                "GOLPEAR CON EL TALÓN EN RÁPIDA SUCESIÓN LEVANTANDO EL PIE DEL SUELO",
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
                  title: const Text('Normal'),
                  value: SigningCharacter.Normal,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ12 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text(
                      'Enlentecimiento discreto y/o reducción de la amplitud.'),
                  value: SigningCharacter.Enlentecimiento,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ12 = 1;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text(
                      'Fatigoso de manera evidente y precoz. Puede haber detenciones ocasionales en el movimiento'),
                  value: SigningCharacter.Moderado,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ12 = 2;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text(
                      'Frecuentes titubeos al iniciar los movimientos o detenciones mientras se realiza el movimiento'),
                  value: SigningCharacter.Alterado,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ12 = 3;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Apenas puede realizar la acción'),
                  value: SigningCharacter.Dificil,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ12 = 4;
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

class BringAnswer12 {
  int send() {
    return selectedStateRadioQ12;
  }
}
