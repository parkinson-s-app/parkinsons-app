import 'package:flutter/material.dart';
import 'InputWrapperRegister.dart';
import 'HeaderRegister.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [Colors.yellow[200], Colors.blue, Colors.blue[700]])),
          child: Column(children: <Widget>[
            SizedBox(
              height: 80,
            ),
            HeaderRegister(),
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      )),
                  child: InputWrapperRegister(),
                ))
          ]),
        ));
  }
}
