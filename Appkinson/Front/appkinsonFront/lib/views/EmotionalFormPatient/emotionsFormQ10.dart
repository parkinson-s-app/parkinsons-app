import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ10 extends StatefulWidget {
  @override
  _emotionsFormQ10 createState() => _emotionsFormQ10();
}


class _emotionsFormQ10 extends State<emotionsFormQ10> {

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
                "Dolores sin causa aparente (no debidos a otras enfermedades, como la artrosis)",
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

class BringAnswer10 {
  int send() {
    return 0;
    //return selectedStateRadioQ10;
  }
}