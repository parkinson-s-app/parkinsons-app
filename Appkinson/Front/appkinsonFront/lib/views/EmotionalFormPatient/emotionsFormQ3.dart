import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ3 extends StatefulWidget {
  @override
  _emotionsFormQ3 createState() => _emotionsFormQ3();
}

enum SigningCharacter {Si, No}
SigningCharacter _character;
int selectedStateRadioQ3 = 0;

class _emotionsFormQ3 extends State<emotionsFormQ3> {

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
                "Dificultad para pasar o deglutir comida o bebidas, o tendencia a atorarse ",
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
                        selectedStateRadioQ3 = 1;
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
                        selectedStateRadioQ3 = 2;
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

class BringAnswer3 {
  int send() {
    return selectedStateRadioQ3;
  }
}