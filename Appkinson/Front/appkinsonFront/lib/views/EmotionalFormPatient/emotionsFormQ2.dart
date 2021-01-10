import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ2 extends StatefulWidget {
  @override
  _emotionsFormQ2 createState() => _emotionsFormQ2();
}


class _emotionsFormQ2 extends State<emotionsFormQ2> {

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
                "Pérdida o alteración en la percepción de sabores u olores ",
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

class BringAnswer2 {
  int send() {
    return 0;
    //return selectedStateRadioQ2;
  }
}