import 'package:flutter/material.dart';
import 'InputWrapperLogin.dart';
import 'HeaderLogin.dart';
import '../HomeInitial/HomePage.dart';

class LoginPage extends StatelessWidget {
  bool shouldPop = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.push( context, new MaterialPageRoute(builder: (context) => HomePage()));
          return shouldPop;
        },
        child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [Colors.yellow[200], Colors.blue, Colors.blue[700]])),
          child: Column(
            children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Header(),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )),
              child: InputWrapper(),
            ))
          ]),
    )));
  }
}
