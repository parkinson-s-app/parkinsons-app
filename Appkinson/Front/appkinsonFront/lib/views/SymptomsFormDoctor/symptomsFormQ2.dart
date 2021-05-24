import 'package:flutter/material.dart';

class symptomsFormQ2 extends StatefulWidget {
  @override
  _symptomsFormQ2 createState() => _symptomsFormQ2();
}

enum SigningCharacter { Normal, Minima, Discreta, Moderada, Fija }
SigningCharacter _character;
int selectedStateRadioQ2 = 0;

class _symptomsFormQ2 extends State<symptomsFormQ2> {
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
                "EXPRESIÓN FACIAL",
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
                  title: const Text('0: Normal   Expresión facial normal.'),
                  value: SigningCharacter.Normal,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ2 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text(
                      '1: Mínimo   Mínima “cara de máscara” (amimia), manifestada únicamente por disminución de la frecuencia del parpadeo. '),
                  value: SigningCharacter.Minima,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ2 = 1;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text(
                      '2: Leve   Además de la disminución de la frecuencia de parpadeo, también presenta amimia en la parte inferior de la cara, es decir, hay menos movimientos alrededor de la boca, como menos sonrisa espontánea, pero sin apertura de los labios. '),
                  value: SigningCharacter.Discreta,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ2 = 2;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text(
                      '3:  Moderado   “Cara de máscara” (amimia) con apertura de labios parte del tiempo cuando la boca está en reposo. '),
                  value: SigningCharacter.Moderada,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ2 = 3;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text(
                      '4: Grave   “Cara de máscara” (amimia) con apertura de labios la mayor parte del tiempo cuando la boca está en reposo.'),
                  value: SigningCharacter.Fija,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ2 = 4;
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

class BringAnswer2 {
  int send() {
    return selectedStateRadioQ2;
  }
}
