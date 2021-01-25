import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ2 extends StatefulWidget {
  @override
  _emotionsFormQ2 createState() => _emotionsFormQ2();
}

enum SigningCharacter {Si, No}
SigningCharacter _character;
int selectedStateRadioQ2 = 0;

class _emotionsFormQ2 extends State<emotionsFormQ2> {

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
                "Pérdida o alteración en la percepción de sabores u olores ",
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: "Ralewaybold",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
                children: <Widget>[
                  Divider(
                    height: 80,
                  ),
                  RadioListTile<SigningCharacter>(
                    title: const Text(
                      'Si',
                      style: TextStyle(
                        fontSize: 40.0,
                      ),
                    ),
                    value: SigningCharacter.Si,
                    groupValue: _character,
                    onChanged: (SigningCharacter value){
                      setState(() {
                        _character = value;
                        selectedStateRadioQ2 = 1;
                      });
                    },
                  ),
                  Divider(
                    height: 100,
                  ),
                  RadioListTile<SigningCharacter>(
                    title: const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 40.0,
                      ),
                    ),
                    value: SigningCharacter.No,
                    groupValue: _character,
                    onChanged: (SigningCharacter value){
                      setState(() {
                        _character = value;
                        selectedStateRadioQ2 = 2;
                      });
                    },
                  ),
                  Divider(
                    height: 80,
                  ),
                ]
            ),

            /*Expanded(
            flex: 1,
          */),
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