import 'dart:io';
import 'package:appkinsonFront/views/SymptomsFormDoctor/videoPluguin.dart';
import 'package:flutter/material.dart';

class symptomsFormQ5 extends StatefulWidget {
  @override
  _symptomsFormQ5 createState() => _symptomsFormQ5();
}

enum SigningCharacter {Ausente, Leve, ModeradoAccion, Moderado, Amplio}
SigningCharacter _character ;
int selectedStateRadioQ5 = 0;

class _symptomsFormQ5 extends State<symptomsFormQ5> {

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
                "TEMBLOR DE ACCIÓN O POSTURAL DE LAS MANOS",
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
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ5 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Leve'),
                  value: SigningCharacter.Leve,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ5 = 1;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Amplitud moderada, presente en la acción'),
                  value: SigningCharacter.ModeradoAccion,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ5 = 2;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Amplitud moderada, postura de manos en el aire'),
                  value: SigningCharacter.Moderado,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ5 = 3;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Interfiere con la alimentación'),
                  value: SigningCharacter.Amplio,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ5 = 4;
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

class BringAnswer5 {
  int send()  {
    return selectedStateRadioQ5;
  }
}