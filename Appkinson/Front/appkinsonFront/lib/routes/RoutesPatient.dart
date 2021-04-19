import 'package:appkinsonFront/views/Calendar/CalendarScreenView2.dart';
import 'package:appkinsonFront/views/Game/countDownGame.dart';
import 'package:appkinsonFront/views/Medicines/medicines.dart';
import 'package:appkinsonFront/views/NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ.dart';
import 'package:appkinsonFront/views/RelationRequest/relationsRequets.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatient.dart';

import 'package:appkinsonFront/views/HomeDifferentUsers/Patient/PatientHomePage.dart';

import 'package:appkinsonFront/views/Notifications/PatientNotifications.dart';
import 'package:appkinsonFront/views/SymptomsFormDoctor/symptomsFormQ.dart';
import 'package:appkinsonFront/views/ToolBox/ToolBoxInitial.dart';
import 'package:appkinsonFront/views/profiles/Patient/PatientProfile.dart';
import 'package:appkinsonFront/views/profiles/Patient/profileEdition/ProfileEditionPatient.dart';
import 'package:flutter/material.dart';

class RoutesPatient {
  toPatientHome(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => PatientHomePage()));
  }

  toCalendar(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => CalendarScreenView2()));
  }

  toNoMotorSymptoms(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => NoMotorSymptomsFormQ()));
  }

  toScheduleMedicines(BuildContext context, int idPatient) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => Medicines(
              idPatient: idPatient,
            )));
  }

  toNotifications(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => PatientNotifications()));
  }

  toRelationsRequest(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => RelationsRequest()));
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

  toSymptomsFormPatient(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => SymptomsFormPatient()));
  }
  toToolbox(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => toolbox()));
  }
  toGame(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => CountDownTimer()));
  }
}
