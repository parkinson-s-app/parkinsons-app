import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ19 extends StatefulWidget {
  @override
  _emotionsFormQ19 createState() => _emotionsFormQ19();
}


class _emotionsFormQ19 extends State<emotionsFormQ19> {

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
                "Dificultades en la relación sexual cuando lo intenta",
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

class BringAnswer19 {
  int send() {
    return 0;
    //return selectedStateRadioQ19;
  }
}