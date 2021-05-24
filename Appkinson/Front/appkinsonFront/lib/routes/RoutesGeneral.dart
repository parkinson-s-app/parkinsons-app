import 'package:appkinsonFront/views/AboutUs/helpSupport.dart';
import 'package:appkinsonFront/views/Login/LoginPage.dart';

import 'package:appkinsonFront/views/Login/resetPassword/passwordChange.dart';
import 'package:appkinsonFront/views/Login/resetPassword/passwordChangeOtm.dart';
import 'package:appkinsonFront/views/Register/RegisterPage.dart';
import 'package:appkinsonFront/views/ToolBox/AboutExcercises/ExcercisesList.dart';
import 'package:appkinsonFront/views/ToolBox/AboutFood/FoodList.dart';
import 'package:appkinsonFront/views/ToolBox/AboutNews/NewsList.dart';
import 'package:flutter/material.dart';

class RoutesGeneral {
  //ruta para registrar un nuevo usuario
  toRegister(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => RegisterPage()));
  }
 //ruta hacia la pantalla de "acerca de nosotros"
  toAboutUs(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => HelpSupport()));
  }
//ruta para el logueo de un usuario nuevo
  toLogin(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => LoginPage()));
  }
//ruta para regresar al contexto anterior
  toPop(BuildContext context) {
    Navigator.pop(context);
  }
//ruta para los items de comida
  toListFood(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ListFood()));
  }
//rutas para listar los ejercicios
  toListExcercises(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ListExcercises()));
  }
//ruta para listar las noticias
  toListNews(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ListNews()));
  }
//ruta hacia cambiar la contraseña
  toChangePassword(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => PasswordChange()));
  }
// ruta para la generación de la otm
  toChangePasswordOtm(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => PasswordChangeOtm()));
  }
}
