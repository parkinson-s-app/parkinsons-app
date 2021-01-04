import 'dart:io';
import 'package:appkinsonFront/views/SymptomsForm/videoPluguin.dart';
import 'package:flutter/material.dart';

class symptomsFormQ10 extends StatefulWidget {
  @override
  _symptomsFormQ10 createState() => _symptomsFormQ10();
}

enum SigningCharacter {Normal, Discreto, Moderado, Impedimento, Dificil}
SigningCharacter _character = SigningCharacter.Normal;
int selectedStateRadioQ10 = 0;

class _symptomsFormQ10 extends State<symptomsFormQ10> {

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
                "ABRIR Y CERRAR LAS MANOS EN RÁPIDA SUCESIÓN CON LA MAYOR AMPLITUD POSIBLE",
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
                      selectedStateRadioQ10 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Enlentecimiento discreto y/o reducción de la amplitud'),
                  value: SigningCharacter.Discreto,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ10 = 1;
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
                      selectedStateRadioQ10 = 2;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Frecuentes titubeos al iniciar los movimientos o detenciones mientras se realiza el movimiento'),
                  value: SigningCharacter.Impedimento,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ10 = 3;
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
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ10 = 4;
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

class BringAnswer10 {
  Future<int> send() async {
    return selectedStateRadioQ10;
  }
}