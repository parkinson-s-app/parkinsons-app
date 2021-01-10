import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ15 extends StatefulWidget {
  @override
  _emotionsFormQ15 createState() => _emotionsFormQ15();
}


class _emotionsFormQ15 extends State<emotionsFormQ15> {

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
                "Dificultad para concentrarse o mantener la atención",
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

class BringAnswer15 {
  int send() {
    return 0;
    //return selectedStateRadioQ15;
  }
}