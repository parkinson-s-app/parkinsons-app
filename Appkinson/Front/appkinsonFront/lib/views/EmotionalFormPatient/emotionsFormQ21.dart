import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ21 extends StatefulWidget {
  @override
  _emotionsFormQ21 createState() => _emotionsFormQ21();
}


class _emotionsFormQ21 extends State<emotionsFormQ21> {

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
                "Caídas",
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

class BringAnswer21 {
  int send() {
    return 0;
    //return selectedStateRadioQ21;
  }
}