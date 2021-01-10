import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ20 extends StatefulWidget {
  @override
  _emotionsFormQ20 createState() => _emotionsFormQ20();
}


class _emotionsFormQ20 extends State<emotionsFormQ20> {

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
                "Sensación de mareo o debilidad al ponerse de pie después de haber estado sentado o tumbado",
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

class BringAnswer20 {
  int send() {
    return 0;
    //return selectedStateRadioQ20;
  }
}