import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ28 extends StatefulWidget {
  @override
  _emotionsFormQ28 createState() => _emotionsFormQ28();
}


class _emotionsFormQ28 extends State<emotionsFormQ28> {

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
                " Sudoración excesiva",
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

class BringAnswer28 {
  int send() {
    return 0;
    //return selectedStateRadioQ28;
  }
}