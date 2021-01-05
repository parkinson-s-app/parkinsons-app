import 'package:appkinsonFront/views/Calendar/CalendarScreen.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Admin/AdminHomePage.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Patient/PatientHomePage.dart';
import 'package:appkinsonFront/views/Login/LoginPage.dart';
import 'package:appkinsonFront/views/Notifications/PatientNotifications.dart';
import 'package:appkinsonFront/views/Register/RegisterPage.dart';
import 'package:appkinsonFront/views/profiles/Patient/PatientProfile.dart';
import 'package:flutter/material.dart';

class RoutesAdmin {
  toAdminHome(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => AdminHomePage()));
  }
}
