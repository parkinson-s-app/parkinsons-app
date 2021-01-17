import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ13 extends StatefulWidget {
  @override
  _emotionsFormQ13 createState() => _emotionsFormQ13();
}


class _emotionsFormQ13 extends State<emotionsFormQ13
> {

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
                "Pérdida de interés en lo que pasa a su alrededor o en realizar sus actividades",
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

class BringAnswer13 {
  int send() {
    return 0;
    //return selectedStateRadioQ13
    //;
  }
}