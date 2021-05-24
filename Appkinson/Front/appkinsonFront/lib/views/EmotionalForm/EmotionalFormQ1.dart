import 'package:flutter/material.dart';

class EmotionalFormQ1 extends StatefulWidget {
  @override
  _EmotionalFormQ1 createState() => _EmotionalFormQ1();
}

enum SigningCharacter { Cero, Uno, Dos, Tres, Nada }
SigningCharacter _character = SigningCharacter.Nada;
int selectedStateRadioQ1;

class _EmotionalFormQ1 extends State<EmotionalFormQ1> {
  void initState() {
    super.initState();

    //_character = SigningCharacter.Nada;
    //selectedStateRadioQ1 = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[350],
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                "Poco interés o placer en hacer cosas",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: "Ralewaybold",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(children: <Widget>[
              Divider(
                height: 60,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'Ningún día',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                value: SigningCharacter.Cero,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ1 = 0;
                  });
                },
              ),
              Divider(
                height: 60,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'Varios días',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                value: SigningCharacter.Uno,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ1 = 1;
                  });
                },
              ),
              Divider(
                height: 60,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'Más de la mitad de los días',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                value: SigningCharacter.Dos,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ1 = 2;
                  });
                },
              ),
              Divider(
                height: 60,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'Casi todos los días',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                value: SigningCharacter.Tres,
                groupValue: _character,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character = value;
                    selectedStateRadioQ1 = 3;
                  });
                },
              ),
              Divider(
                height: 60,
              ),
            ]),

            /*Expanded(
            flex: 1,
          */
          ),
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

class RestartListTile {
  void setTile1(){
    _character = SigningCharacter.Nada;
  }
}