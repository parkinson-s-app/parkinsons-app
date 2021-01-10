import 'dart:io';
import 'package:flutter/material.dart';

class emotionsFormQ26 extends StatefulWidget {
  @override
  _emotionsFormQ26 createState() => _emotionsFormQ26();
}


class _emotionsFormQ26 extends State<emotionsFormQ26> {

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
                "Sensaciones desagradables en las piernas por la noche o cuando está descansando, y sensación de que necesita moverlas",
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

class BringAnswer26 {
  int send() {
    return 0;
    //return selectedStateRadioQ26;
  }
}