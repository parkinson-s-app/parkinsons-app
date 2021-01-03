import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonLinkPatient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () {
          //addUser();
        },
        padding: EdgeInsets.symmetric(horizontal: 50),
        color: Colors.blue,
        textColor: Colors.white,
        child: Text("Agregar Paciente", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
