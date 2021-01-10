import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ12 extends StatefulWidget {
  @override
  _emotionsFormQ12 createState() => _emotionsFormQ12();
}


class _emotionsFormQ12 extends State<emotionsFormQ12> {

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
                "Problemas para recordar cosas que han pasado recientemente o dificultad para acordarse de cosas que tenía que hacer",
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

class BringAnswer12 {
  int send() {
    return 0;
    //return selectedStateRadioQ12;
  }
}