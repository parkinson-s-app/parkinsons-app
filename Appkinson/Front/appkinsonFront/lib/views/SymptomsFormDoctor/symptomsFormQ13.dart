import 'dart:io';
import 'package:appkinsonFront/views/SymptomsFormDoctor/videoPluguin.dart';
import 'package:flutter/material.dart';

class symptomsFormQ13 extends StatefulWidget {
  @override
  _symptomsFormQ13 createState() => _symptomsFormQ13();
}

enum SigningCharacter {Normal, Lento, Impulso, Dificultad, Incapaz}
SigningCharacter _character;
int selectedStateRadioQ13 = 0;

class _symptomsFormQ13 extends State<symptomsFormQ13> {

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
                "LEVANTARSE DE UNA SILLA CON LOS BRAZOS CRUZADOS ANTE EL PECHO",
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
                      selectedStateRadioQ13 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Lento, o puede necesitar más de un intento'),
                  value: SigningCharacter.Lento,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ13 = 1;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Tiene que impulsarse con los brazos de la silla'),
                  value: SigningCharacter.Impulso,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ13 = 2;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Tiende a caer hacia atrás y puede tener que intentarlo más de una vez, pero puede conseguirlo sin ayuda'),
                  value: SigningCharacter.Dificultad,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ13 = 3;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('Incapaz de levantarse sin ayuda'),
                  value: SigningCharacter.Incapaz,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ13 = 4;
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

class BringAnswer13 {
  int send()  {
    return selectedStateRadioQ13;
  }
}