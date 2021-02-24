import 'package:flutter/material.dart';

class symptomsFormQ9 extends StatefulWidget {
  @override
  _symptomsFormQ9 createState() => _symptomsFormQ9();
}

enum SigningCharacter { Normal, Discreto, Moderado, Impedimento, Dificil }
SigningCharacter _character;
int selectedStateRadioQ9 = 0;

class _symptomsFormQ9 extends State<symptomsFormQ9> {
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
                "GOLPEAR EL PULGAR CON EL ÍNDICE EN RÁPIDA SUCECIÓN Y CON LA MAYOR AMPLITUD POSIBLE; REALIZAR CON CADA MANO POR SEPARADO",
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
                  title: const Text('Normal (15/5 segundos'),
                  value: SigningCharacter.Normal,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ9 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text(
                      'Enlentecimiento discreto y/o reducción de la amplitud (11-15/5segundos)'),
                  value: SigningCharacter.Discreto,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ9 = 1;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text(
                      'Moderadamente alterado. Fatigoso de manera evidente y precoz. Puede haber detenciones ocasionales en el movimiento (7-10/5segundos)'),
                  value: SigningCharacter.Moderado,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ9 = 2;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text(
                      'Muy alterado. Frecuentes titubeos al iniciar los movimientos o detenciones mientras se realiza el movimiento (3-6/5segundos).'),
                  value: SigningCharacter.Impedimento,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ9 = 3;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Apenas puede realizar el ejercicio.'),
                  value: SigningCharacter.Dificil,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ9 = 4;
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

class BringAnswer9 {
  int send() {
    return selectedStateRadioQ9;
  }
}
