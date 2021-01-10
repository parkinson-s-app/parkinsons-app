import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ18 extends StatefulWidget {
  @override
  _emotionsFormQ18 createState() => _emotionsFormQ18();
}


class _emotionsFormQ18 extends State<emotionsFormQ18> {

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
                "Pérdida o aumento del interés por el sexo",
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

class BringAnswer18 {
  int send() {
    return 0;
    //return selectedStateRadioQ18;
  }
}