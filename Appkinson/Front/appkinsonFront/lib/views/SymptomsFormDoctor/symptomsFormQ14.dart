import 'dart:io';
import 'package:appkinsonFront/views/SymptomsFormDoctor/videoPluguin.dart';
import 'package:flutter/material.dart';

class symptomsFormQ14 extends StatefulWidget {
  @override
  _symptomsFormQ14 createState() => _symptomsFormQ14();
}

enum SigningCharacter {Normal, PocoEncorvada, ModeradoEncorvada, MuyEncorvada, Extrema}
SigningCharacter _character;
int selectedStateRadioQ14 = 0;

class _symptomsFormQ14 extends State<symptomsFormQ14> {

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
                "POSTURA",
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
                  title: const Text('Erecta normal'),
                  value: SigningCharacter.Normal,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ14 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Postura no muy erecta, discretamente encorvada; podría ser normal en una persona mayor'),
                  value: SigningCharacter.PocoEncorvada,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ14 = 1;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Postura moderadamente encorvada, claramente anormal. Puede inclinarse discretamente a un lado'),
                  value: SigningCharacter.ModeradoEncorvada,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ14 = 2;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Postura muy encorvada'),
                  value: SigningCharacter.MuyEncorvada,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ14 = 3;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Flexión marcada con alteración postural extrema'),
                  value: SigningCharacter.Extrema,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ14 = 4;
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

class BringAnswer14 {
  int send()  {
    return selectedStateRadioQ14;
  }
}