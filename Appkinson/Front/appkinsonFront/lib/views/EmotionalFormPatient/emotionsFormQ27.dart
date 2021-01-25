import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ27 extends StatefulWidget {
  @override
  _emotionsFormQ27 createState() => _emotionsFormQ27();
}

enum SigningCharacter {Si, No}
SigningCharacter _character;
int selectedStateRadioQ27 = 0;

class _emotionsFormQ27 extends State<emotionsFormQ27> {

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
                "Hinchazón en las piernas.",
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
                        selectedStateRadioQ27 = 1;
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
                        selectedStateRadioQ27 = 2;
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

class BringAnswer27 {
  int send() {
    return 0;
    //return selectedStateRadioQ27;
  }
}