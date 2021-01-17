import 'package:appkinsonFront/views/Calendar/CalendarScreen.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Patient/PatientHomePage.dart';
import 'package:appkinsonFront/views/Login/LoginPage.dart';
import 'package:appkinsonFront/views/Notifications/PatientNotifications.dart';
import 'package:appkinsonFront/views/Register/RegisterPage.dart';
import 'package:appkinsonFront/views/SymptomsFormDoctor/symptomsFormQ.dart';
import 'package:appkinsonFront/views/profiles/Patient/PatientProfile.dart';
import 'package:appkinsonFront/views/profiles/Patient/profileEdition/ProfileEditionPatient.dart';
import 'package:flutter/material.dart';

class RoutesPatient {
  toPatientHome(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => PatientHomePage()));
  }

  toCalendar(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => CalendarScreen()));
  }

  toNotifications(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => PatientNotifications()));
  }

  toPatientProfile(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MyHomePage1()));
  }

  toPatientEditProfile(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ProfileEditionPatient()));
  }

  toSymptomsForm(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => symptomsFormQ()));
  }
}
