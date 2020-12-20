import 'dart:convert';

import 'package:flutter/material.dart';

import '../../Login/LoginPage.dart';

class ButtonGoLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 50),
        color: Colors.white,
        textColor: Colors.blue,
        child: Text("¿Ya tienes una cuenta? ", style: TextStyle(fontSize: 13)),
      ),
    );
  }
}
