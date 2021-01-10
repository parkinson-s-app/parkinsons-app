import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ7 extends StatefulWidget {
  @override
  _emotionsFormQ7 createState() => _emotionsFormQ7();
}


class _emotionsFormQ7 extends State<emotionsFormQ7> {

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
                "Sensación de no haber vaciado por completo el vientre después de ir al servicio",
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

class BringAnswer7 {
  int send() {
    return 0;
    //return selectedStateRadioQ7;
  }
}