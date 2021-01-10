import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ6 extends StatefulWidget {
  @override
  _emotionsFormQ6 createState() => _emotionsFormQ6();
}


class _emotionsFormQ6 extends State<emotionsFormQ6
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
                "Incontinencia fecal (se escapan las heces)",
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

class BringAnswer6 {
  int send() {
    return 0;
    //return selectedStateRadioQ6
    //;
  }
}