import 'dart:developer';

import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:flutter/material.dart';

class PasswordChange extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

TextEditingController emailRecoverController = new TextEditingController();

class _LoginPageState extends State<PasswordChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Cambiar Contraseña",
          ),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(3.0),
            ),
          ],
        ),
        body: Center(
            child: ListView(
          padding: EdgeInsets.all(32),
          children: [
            SizedBox(
              height: 200,
            ),
            TextField(
              textInputAction: TextInputAction.done,
              controller: emailRecoverController,
              decoration: InputDecoration(
                  hintText: "Ingrese su Correo Eléctronico",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
                style: TextButton.styleFrom(
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0))),
                onPressed: () {
                  print('hey');
                  EndPoints().passwordRecover(emailRecoverController.text);
                  RoutesGeneral().toChangePasswordOtm(context);
                },
                child: Text('Enviar Código')),
          ],
        )));
  }
}
