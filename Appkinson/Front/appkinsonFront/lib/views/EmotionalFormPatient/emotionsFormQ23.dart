import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ23 extends StatefulWidget {
  @override
  _emotionsFormQ23 createState() => _emotionsFormQ23();
}


class _emotionsFormQ23 extends State<emotionsFormQ23> {

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
                "Dificultad para quedarse o mantenerse dormido por la noche",
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

class BringAnswer23 {
  int send() {
    return 0;
    //return selectedStateRadioQ23;
  }
}