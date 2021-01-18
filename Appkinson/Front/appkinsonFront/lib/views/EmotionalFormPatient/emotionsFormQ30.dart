import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ30 extends StatefulWidget {
  @override
  _emotionsFormQ30 createState() => _emotionsFormQ30();
}


class _emotionsFormQ30 extends State<emotionsFormQ30> {

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
                "Creer que le pasan cosas que otras personas le dicen que no son verdad.",
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

class BringAnswer30 {
  int send() {
    return 0;
    //return selectedStateRadioQ30;
  }
}