import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ27 extends StatefulWidget {
  @override
  _emotionsFormQ27 createState() => _emotionsFormQ27();
}


class _emotionsFormQ27 extends State<emotionsFormQ27> {

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
                "Hinchazón en las piernas.",
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

class BringAnswer27 {
  int send() {
    return 0;
    //return selectedStateRadioQ27;
  }
}