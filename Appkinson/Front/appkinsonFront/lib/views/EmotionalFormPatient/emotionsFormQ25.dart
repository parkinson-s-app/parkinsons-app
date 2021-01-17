import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ25 extends StatefulWidget {
  @override
  _emotionsFormQ25 createState() => _emotionsFormQ25();
}


class _emotionsFormQ25 extends State<emotionsFormQ25> {

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
                " Hablar o moverse durante el sueño como si lo estuviera viviendo",
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

class BringAnswer25 {
  int send() {
    return 0;
    //return selectedStateRadioQ25;
  }
}