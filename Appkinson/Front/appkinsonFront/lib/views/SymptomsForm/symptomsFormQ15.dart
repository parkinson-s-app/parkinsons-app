import 'dart:io';
import 'package:appkinsonFront/views/SymptomsForm/videoPluguin.dart';
import 'package:flutter/material.dart';

class symptomsFormQ15 extends StatefulWidget {
  @override
  _symptomsFormQ15 createState() => _symptomsFormQ15();
}

enum SigningCharacter {Normal, Lento, Dificultad, Grave, Impedimento}
SigningCharacter _character = SigningCharacter.Normal;
int selectedStateRadioQ15 = 0;

class _symptomsFormQ15 extends State<symptomsFormQ15> {

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
                "MARCHA",
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
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ15 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Camina lentamente, puede arrastrar los pies, con pasos cortos'),
                  value: SigningCharacter.Lento,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ15 = 1;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Camina con dificultad, pero no requiere ayuda o muy escasa'),
                  value: SigningCharacter.Dificultad,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ15 = 2;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Trastornos graves de la marcha que requieren ayuda.'),
                  value: SigningCharacter.Grave,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ15 = 3;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('No puede caminar, incluso con ayuda.'),
                  value: SigningCharacter.Impedimento,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ15 = 4;
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

class BringAnswer15 {
  Future<int> send() async {
    return selectedStateRadioQ15;
  }
}