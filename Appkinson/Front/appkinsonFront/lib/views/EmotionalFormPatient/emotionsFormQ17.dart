import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ17 extends StatefulWidget {
  @override
  _emotionsFormQ17 createState() => _emotionsFormQ17();
}


class _emotionsFormQ17 extends State<emotionsFormQ17> {

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
                "Sentimientos de ansiedad, miedo o pánico",
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

class BringAnswer17 {
  int send() {
    return 0;
    //return selectedStateRadioQ17;
  }
}