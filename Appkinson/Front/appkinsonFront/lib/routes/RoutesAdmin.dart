import 'package:appkinsonFront/views/HomeDifferentUsers/Admin/AdminHomePage.dart';

import 'package:flutter/material.dart';

class RoutesAdmin {
  toAdminHome(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => AdminHomePage()));
  }
}
