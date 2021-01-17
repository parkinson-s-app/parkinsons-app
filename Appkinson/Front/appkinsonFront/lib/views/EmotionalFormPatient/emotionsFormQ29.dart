import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ29 extends StatefulWidget {
  @override
  _emotionsFormQ29 createState() => _emotionsFormQ29();
}


class _emotionsFormQ29 extends State<emotionsFormQ29> {

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
                "Visión doble",
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

class BringAnswer29 {
  int send() {
    return 0;
    //return selectedStateRadioQ29;
  }
}