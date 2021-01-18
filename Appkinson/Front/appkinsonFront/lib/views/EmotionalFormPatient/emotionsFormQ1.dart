import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ1 extends StatefulWidget {
  @override
  _emotionsFormQ1 createState() => _emotionsFormQ1();
}


class _emotionsFormQ1 extends State<emotionsFormQ1> {

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
                "Babeo durante el día",
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

class BringAnswer1 {
  int send() {
    return 0;
    //return selectedStateRadioQ1;
  }
}