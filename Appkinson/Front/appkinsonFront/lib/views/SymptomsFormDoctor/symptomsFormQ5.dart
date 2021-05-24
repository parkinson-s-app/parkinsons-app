import 'package:flutter/material.dart';

class symptomsFormQ5 extends StatefulWidget {
  @override
  _symptomsFormQ5 createState() => _symptomsFormQ5();
}

enum SigningCharacter { Ausente, Leve, ModeradoAccion, Moderado, Amplio }
SigningCharacter _character;
int selectedStateRadioQ5 = 0;

class _symptomsFormQ5 extends State<symptomsFormQ5> {
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
                "MOVIMIENTOS CON LAS MANOS",
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
                      selectedStateRadioQ5 = 0;
                    });
                  },
                ),
                Divider(
                  height: 20,
                ),
                RadioListTile<SigningCharacter>(
                  title: const Text('1: Mínimo   Cualquiera de lo siguiente: a) el ritmo regular se rompe con una o dos interrupciones o titubeos en el movimiento; b) mínimo enlentecimiento; c) la amplitud disminuye cerca del final de la tarea. '),
                  value: SigningCharacter.Leve,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
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
                  title: const Text('2: Leve   Cualquiera de los siguientes: a) de 3 a 5 interrupciones durante los movimientos; b) enlentecimiento leve; c) la amplitud disminuye hacia la mitad de la tarea.'),
                  value: SigningCharacter.ModeradoAccion,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
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
                  title: const Text('3: Moderado   Cualquiera de los siguientes: a) más de 5 interrupciones durante el movimiento o al menos una interrupción prolongada (congelación) durante el movimiento en curso; b) moderado enlentecimiento; c) la amplitud disminuye después de la primera secuencia de “abrir y cerrar”.'),
                  value: SigningCharacter.Moderado,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
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
                  title: const Text('4: Grave   No puede o casi no puede ejecutar la tarea debido a enlentecimiento, interrupciones o decrementos'),
                  value: SigningCharacter.Amplio,
                  groupValue: _character,
                  onChanged: (SigningCharacter value) {
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
  int send() {
    return selectedStateRadioQ5;
  }
}
