import 'package:appkinsonFront/views/Login/LoginPage.dart';
import 'package:appkinsonFront/views/Register/RegisterPage.dart';
import 'package:flutter/material.dart';

class RoutesGeneral {
  toRegister(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => RegisterPage()));
  }

  toLogin(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => LoginPage()));
  }

  toPop(BuildContext context) {
    Navigator.pop(context);
  }
}
