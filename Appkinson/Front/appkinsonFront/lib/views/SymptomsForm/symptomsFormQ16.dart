import 'dart:io';
import 'package:appkinsonFront/views/SymptomsForm/videoPluguin.dart';
import 'package:flutter/material.dart';

class symptomsFormQ16 extends StatefulWidget {
  @override
  _symptomsFormQ16 createState() => _symptomsFormQ16();
}

enum SigningCharacter {Inexistente, Minima, Leve, Moderada, Marcada}
SigningCharacter _character = SigningCharacter.Inexistente;
int selectedStateRadioQ16 = 0;

class _symptomsFormQ16 extends State<symptomsFormQ16> {

  @override
  Widget build(BuildContext context){
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
                "DISMINUCIÓN DE VELOCIDAD Y DIFICULTADES EN MOVIMIENTOS MOTORES",
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
                  title: const Text('No hay'),
                  value: SigningCharacter.Inexistente,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ16 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Mínima lentitud que da al movimiento un carácter deliberado, podría ser normal en algunas personas. Amplitud posiblemente reducida.'),
                  value: SigningCharacter.Minima,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ16 = 1;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Lentitud y pobreza de movimientos en grado leve, que es claramente anormal. Como alternativa, cierto grado de reducción en la amplitud'),
                  value: SigningCharacter.Leve,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ16 = 2;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Lentitud, pobreza o pequeña amplitud de movimientos moderado'),
                  value: SigningCharacter.Moderada,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ16 = 3;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Lentitud, pobreza o pequeña amplitud de movimientos marcado.'),
                  value: SigningCharacter.Marcada,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ16 = 4;
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

class BringAnswer16 {
  Future<int> send() async {
    return selectedStateRadioQ16;
  }
}