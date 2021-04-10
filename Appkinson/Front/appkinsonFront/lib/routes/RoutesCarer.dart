import 'package:appkinsonFront/views/Calendar/CalendarScreenView2Carer.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Carer/CarerHomePage.dart';
import 'package:appkinsonFront/views/Relations/CarerPatients.dart';
import 'package:appkinsonFront/views/Relations/interactionCarerPatient.dart';
import 'package:appkinsonFront/views/ToolBox/ToolBoxInitial.dart';
import 'package:appkinsonFront/views/profiles/Carer/CarerProfle.dart';
import 'package:appkinsonFront/views/profiles/Carer/profileEdition/ProfileEditionCarer.dart';
import 'package:flutter/material.dart';
import '../views/Relations/DoctorPatientAdd.dart';

class RoutesCarer {
  toCarerHome(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => CarerHomePage()));
  }

  toCarerProfile(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MyHomePage3()));
  }

  toCalendarCarer(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => CalendarScreenView2Carer()));
  }

  toPatientList(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => CarerPatients()));
  }

  toAddUser(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => DoctorPatientsAdd()));
  }

  toCarerEditProfile(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ProfileEditionCarer()));
  }

  toInteractionCarerPatient(BuildContext context, int idPatient) {
    print('patient pantalla intermedia ${idPatient.toString()}');
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => InteractionCarerPatient(
                  idPatient: idPatient,
                )));
  }

  toToolbox(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => toolbox()));
  }
}
