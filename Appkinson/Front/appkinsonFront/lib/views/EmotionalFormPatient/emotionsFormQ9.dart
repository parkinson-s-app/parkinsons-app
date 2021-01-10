import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ9 extends StatefulWidget {
  @override
  _emotionsFormQ9 createState() => _emotionsFormQ9();
}


class _emotionsFormQ9 extends State<emotionsFormQ9> {

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
                "Necesidad de levantarse habitualmente por la noche a orinar",
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

class BringAnswer9 {
  int send() {
    return 0;
    //return selectedStateRadioQ9;
  }
}