import 'package:appkinsonFront/views/Administrator/FormAddItem.dart';
import 'package:appkinsonFront/views/Administrator/ListItemsAdministrator.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Admin/AdminHomePage.dart';

import 'package:flutter/material.dart';

class RoutesAdmin {
  //ruta hacia el home del administrador
  toAdminHome(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => AdminHomePage()));
  }
  //ruta hacia la pantalla agregar item
  toFormAddItem(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => FormItemToolboxPage()));
  }
  //ruta hacia la pantallaa listar items
  toListItems(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ListItemsAdministrator()));
  }

}
