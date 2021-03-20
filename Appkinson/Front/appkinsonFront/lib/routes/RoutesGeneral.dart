import 'package:appkinsonFront/views/AboutUs/helpSupport.dart';
import 'package:appkinsonFront/views/Login/LoginPage.dart';
import 'package:appkinsonFront/views/Register/RegisterPage.dart';
import 'package:appkinsonFront/views/ToolBox/AboutExcercises/ExcercisesList.dart';
import 'package:appkinsonFront/views/ToolBox/AboutFood/FoodList.dart';
import 'package:appkinsonFront/views/ToolBox/AboutNews/NewsList.dart';
import 'package:flutter/material.dart';

class RoutesGeneral {
  toRegister(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => RegisterPage()));
  }

  toAboutUs(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => HelpSupport()));
  }

  toLogin(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => LoginPage()));
  }

  toPop(BuildContext context) {
    Navigator.pop(context);
  }
  toListFood(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ListFood()));
  }

  /*toListExcercises(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ListExcercises()));
  }
  toListNews(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ListNews()));
  }*/
}
