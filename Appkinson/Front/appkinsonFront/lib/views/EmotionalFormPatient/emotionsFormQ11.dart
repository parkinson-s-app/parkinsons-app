import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ11 extends StatefulWidget {
  @override
  _emotionsFormQ11 createState() => _emotionsFormQ11();
}


class _emotionsFormQ11 extends State<emotionsFormQ11> {

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
                "Cambio de peso sin causa aparente (no debido a un régimen o dieta",
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

class BringAnswer11 {
  int send() {
    return 0;
    //return selectedStateRadioQ11;
  }
}