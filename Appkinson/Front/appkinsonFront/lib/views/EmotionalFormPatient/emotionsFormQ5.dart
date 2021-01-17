import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ5 extends StatefulWidget {
  @override
  _emotionsFormQ5 createState() => _emotionsFormQ5();
}


class _emotionsFormQ5 extends State<emotionsFormQ5> {

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
                "Estreñimiento (hacer de vientre menos de 3 veces a la semana) o tener que hacer esfuerzos para hacer de vientre",
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

class BringAnswer5 {
  int send() {
    return 0;
    //return selectedStateRadioQ5;
  }
}