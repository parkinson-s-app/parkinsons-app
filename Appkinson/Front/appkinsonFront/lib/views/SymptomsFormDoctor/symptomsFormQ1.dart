import 'dart:io';
import 'package:appkinsonFront/views/SymptomsFormDoctor/videoPluguin.dart';
import 'package:flutter/material.dart';

class symptomsFormQ1 extends StatefulWidget {
  @override
  _symptomsFormQ1 createState() => _symptomsFormQ1();
}

enum SigningCharacter {Normal, PerdidaDeExpresion, Monotono, Alterado, Ininteligible}
SigningCharacter _character;
int selectedStateRadioQ1 = 0;

class _symptomsFormQ1 extends State<symptomsFormQ1> {

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
                "LENGUAJE",
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
                  title: const Text('0: Normal   Sin problemas de lenguaje.'),
                  value: SigningCharacter.Normal,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ1 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('1: Mínimo   Pérdida de modulación, dicción, o volumen, pero todas las palabras se entienden fácilmente. '),
                  value: SigningCharacter.PerdidaDeExpresion,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ1 = 1;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('2: Leve   Pérdida de modulación, dicción, o volumen, con algunas palabras poco claras, pero se pueden entender las frases en conjunto'),
                  value: SigningCharacter.Monotono,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ1 = 2;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('3: Moderado   El lenguaje es difícil de entender hasta tal punto que algunas, pero no todas las frases, se entienden mal. '),
                  value: SigningCharacter.Alterado,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ1 = 3;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('4: Grave   La mayor parte del lenguaje es difícil de entender o ininteligible'),
                  value: SigningCharacter.Ininteligible,
                  groupValue: _character,
                  onChanged: (SigningCharacter value){
                    setState(() {
                      _character = value;
                      selectedStateRadioQ1 = 4;
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

class BringAnswer1 {
  int send() {
    return selectedStateRadioQ1;
  }
}