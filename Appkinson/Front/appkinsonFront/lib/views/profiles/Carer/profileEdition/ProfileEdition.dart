import 'dart:io';
import 'package:flutter/material.dart';

class ProfileEdition extends StatefulWidget {
  @override
  __ProfileEdition createState() => __ProfileEdition();
}

TextEditingController emailController = new TextEditingController();

class __ProfileEdition extends State<ProfileEdition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[200]))),
        child: TextField(
          controller: emailController,
          decoration: InputDecoration(
              hintText: "Ingrese su correo eléctronico",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none),
        ),
      ),
    ]));
  }
}
