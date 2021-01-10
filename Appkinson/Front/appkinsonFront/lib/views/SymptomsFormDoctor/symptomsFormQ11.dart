import 'dart:io';
import 'package:appkinsonFront/views/SymptomsFormDoctor/videoPluguin.dart';
import 'package:flutter/material.dart';

class symptomsFormQ11 extends StatefulWidget {
  @override
  _symptomsFormQ11 createState() => _symptomsFormQ11();
}

enum SigningCharacter {Normal, Enlentecimiento, Moderado, Alterado, Dificil}
SigningCharacter _character;
int selectedStateRadioQ11 = 0;

class _symptomsFormQ11 extends State<symptomsFormQ11> {

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
                "MOVIMIENTOS DE PRONACIÓN-SUPINACIÓN DE LAS MANOS",
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
                      selectedStateRadioQ11 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Enlentecimiento discreto y/o reducción de la amplitud.'),
                  value: SigningCharacter.Enlentecimiento,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ11 = 1;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Fatigoso de manera evidente y precoz. Puede haber detenciones ocasionales en el movimiento'),
                  value: SigningCharacter.Moderado,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ11 = 2;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Frecuentes titubeos al iniciar los movimientos o detenciones mientras se realiza el movimiento'),
                  value: SigningCharacter.Alterado,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ11 = 3;
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
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ11 = 4;
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

class BringAnswer11 {
  int send()  {
    return selectedStateRadioQ11;
  }
}