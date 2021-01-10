import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ4 extends StatefulWidget {
  @override
  _emotionsFormQ4 createState() => _emotionsFormQ4();
}


class _emotionsFormQ4 extends State<emotionsFormQ4> {

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
                "Vómitos o nauseas",
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

class BringAnswer4 {
  int send() {
    return 0;
    //return selectedStateRadioQ4;
  }
}