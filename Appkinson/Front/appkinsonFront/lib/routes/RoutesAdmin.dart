import 'package:appkinsonFront/views/Administrator/FormAddItem.dart';
import 'package:appkinsonFront/views/Administrator/ListItemsAdministrator.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Admin/AdminHomePage.dart';

import 'package:flutter/material.dart';

class RoutesAdmin {
  toAdminHome(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => AdminHomePage()));
  }

  toFormAddItem(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => FormItemToolboxPage()));
  }
  toListItems(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ListItemsAdministrator()));
  }

}
