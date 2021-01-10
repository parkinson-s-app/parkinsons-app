import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ8 extends StatefulWidget {
  @override
  _emotionsFormQ8 createState() => _emotionsFormQ8();
}


class _emotionsFormQ8 extends State<emotionsFormQ8> {

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
                "Sensación de tener que orinar urgentemente que le obliga a ir rápidamente al servici",
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

class BringAnswer8 {
  int send() {
    return 0;
    //return selectedStateRadioQ8;
  }
}