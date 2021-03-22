import 'package:appkinsonFront/views/Calendar/CalendarScreenView2Doctor.dart';
import 'package:appkinsonFront/views/AlarmsAndMedicine/AlarmAndMedicinePage.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Doctor/DoctorHomePage.dart';

import 'package:appkinsonFront/views/Relations/DoctorPatients.dart';
import 'package:appkinsonFront/views/Relations/interactionDoctorPatient.dart';
import 'package:appkinsonFront/views/Report/report.dart';
import 'package:appkinsonFront/views/Report/reportConfig.dart';
import 'package:appkinsonFront/views/profiles/Doctor/DoctorProfile.dart';
import 'package:appkinsonFront/views/profiles/Doctor/profileEdition/ProfileEditionDoctor.dart';
import 'package:flutter/material.dart';

class RoutesDoctor {
  toDoctorHome(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => DoctorHomePage()));
  }

 /* toCalendarDoctor(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => ReportConfigPage()));
  }*/
  toReportConfigPage(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => ReportConfigPage()));
  }

  toReportPage(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => ReportPage()));
  }

  toInteractionDoctorPatient(BuildContext context, int idPatient) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => InteractionDoctorPatient(
                  idPatient: idPatient,
                )));
  }

  toDoctorProfile(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MyHomePage2()));
  }

  toPatientList(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => DoctorPatients()));
  }

  toDoctorEditProfile(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ProfileEditionDoctor()));
  }


  toPatientAlarmAndMedicine(BuildContext context, int idPatient) {
    print('otro idpat ${idPatient.toString()}');
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => AlarmAndMedicinePage(
                  idPatient: idPatient,
                )));
  }
}
