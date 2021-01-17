import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ14 extends StatefulWidget {
  @override
  _emotionsFormQ14 createState() => _emotionsFormQ14();
}


class _emotionsFormQ14 extends State<emotionsFormQ14
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
                "Ver u oír cosas que sabe o que otras personas le dicen que no están ahí",
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

class BringAnswer14 {
  int send() {
    return 0;
    //return selectedStateRadioQ14
    //;
  }
}