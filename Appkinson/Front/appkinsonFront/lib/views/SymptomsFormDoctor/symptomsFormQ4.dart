import 'package:flutter/material.dart';

class symptomsFormQ4 extends StatefulWidget {
  @override
  _symptomsFormQ4 createState() => _symptomsFormQ4();
}

enum SigningCharacter { Ausente, Infrecuente, Persistente, Mayoria, Presente }
SigningCharacter _character;
int selectedStateRadioQ4 = 0;

class _symptomsFormQ4 extends State<symptomsFormQ4> {
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
                " GOLPETEO DE DEDOS (FINGER TAPPING)",
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
                  title: const Text('0: Normal   Sin problemas. '),
                  value: SigningCharacter.Ausente,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ4 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('1: Mínimo   Cualquiera de los siguientes: a) el ritmo regular se rompe con una o dos interrupciones o titubeos en el movimiento de golpeteo; b) mínimo enlentecimiento; c) la amplitud disminuye cerca del final de los 10 golpeteos.'),
                  value: SigningCharacter.Infrecuente,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ4 = 1;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('2: Leve   Cualquiera de los siguientes: a) de 3 a 5 interrupciones durante el golpeteo; b) enlentecimiento leve; c) la amplitud disminuye hacia la mitad de la secuencia de 10 golpeteos. '),
                  value: SigningCharacter.Persistente,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ4 = 2;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('3: Moderado   Cualquiera de los siguientes: a) más de 5 interrupciones durante el golpeteo o al menos una interrupción más prolongada (congelación) durante el movimiento en curso; b) enlentecimiento moderado; c) la amplitud disminuye después del primer golpeteo.'),
                  value: SigningCharacter.Mayoria,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
                    setState(() {
                      _character = value;
                      selectedStateRadioQ4 = 3;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('4: Grave   No puede o apenas puede realizar la tarea debido a enlentecimiento, interrupciones o decrementos.'),
                  value: SigningCharacter.Presente,
                      selectedStateRadioQ4 = 4;
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

class BringAnswer4 {
  int send() {
    return selectedStateRadioQ4;
  }
}
