import 'package:appkinsonFront/views/Calendar/CalendarScreen.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Carer/CarerHomePage.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Patient/PatientHomePage.dart';
import 'package:appkinsonFront/views/Login/LoginPage.dart';
import 'package:appkinsonFront/views/Notifications/PatientNotifications.dart';
import 'package:appkinsonFront/views/Register/RegisterPage.dart';
import 'package:appkinsonFront/views/profiles/Carer/CarerProfle.dart';
import 'package:appkinsonFront/views/profiles/Carer/profileEdition/ProfileEditionCarer.dart';
import 'package:appkinsonFront/views/profiles/Patient/PatientProfile.dart';
import 'package:flutter/material.dart';

class RoutesCarer {
  toCarerHome(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => CarerHomePage()));
  }

  toCarerProfile(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MyHomePage3()));
  }

  toCarerEditProfile(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ProfileEditionCarer()));
  }
}
