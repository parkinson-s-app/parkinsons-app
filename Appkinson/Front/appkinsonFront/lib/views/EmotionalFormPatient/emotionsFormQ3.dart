import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ3 extends StatefulWidget {
  @override
  _emotionsFormQ3 createState() => _emotionsFormQ3();
}


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
                "Dificultad para tragar comida o bebidas, o tendencia a atragantarse ",
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
            flex: 2,
          ),*/
        ],
      ),
    );
  }
}

class BringAnswer3 {
  int send() {
    return 0;
    //return selectedStateRadioQ2;
  }
}