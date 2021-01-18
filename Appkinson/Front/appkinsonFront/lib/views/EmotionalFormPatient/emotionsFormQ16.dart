import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ16 extends StatefulWidget {
  @override
  _emotionsFormQ16 createState() => _emotionsFormQ16();
}


class _emotionsFormQ16 extends State<emotionsFormQ16> {

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
                "Sentirse triste, bajo/a de ánimo o decaído",
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
                //Opciones de si y no
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

class BringAnswer16 {
  int send() {
    return 0;
    //return selectedStateRadioQ16;
  }
}