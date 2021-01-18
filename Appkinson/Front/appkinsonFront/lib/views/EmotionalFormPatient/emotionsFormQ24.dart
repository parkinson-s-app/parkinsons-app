import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ24 extends StatefulWidget {
  @override
  _emotionsFormQ24 createState() => _emotionsFormQ24();
}


class _emotionsFormQ24 extends State<emotionsFormQ24> {

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
                "Sueños intensos, vívidos o pesadillas.",
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

class BringAnswer24 {
  int send() {
    return 0;
    //return selectedStateRadioQ24;
  }
}