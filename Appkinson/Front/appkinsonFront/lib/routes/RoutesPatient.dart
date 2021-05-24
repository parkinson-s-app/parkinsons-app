import 'package:appkinsonFront/views/Calendar/CalendarScreenView2.dart';
import 'package:appkinsonFront/views/EmotionalForm/EmotionalFormQ.dart';
import 'package:appkinsonFront/views/Game/countDownGame.dart';
import 'package:appkinsonFront/views/Medicines/medicines.dart';
import 'package:appkinsonFront/views/NoMotorSymptomsFormPatient/NoMotorSymptomsFormQ.dart';
import 'package:appkinsonFront/views/RelationRequest/relationsRequets.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatient.dart';

import 'package:appkinsonFront/views/HomeDifferentUsers/Patient/PatientHomePage.dart';

import 'package:appkinsonFront/views/Notifications/PatientNotifications.dart';
import 'package:appkinsonFront/views/SymptomsFormDoctor/symptomsFormQ.dart';
import 'package:appkinsonFront/views/ToolBox/AboutParkinson/Buttons/Information.dart';
import 'package:appkinsonFront/views/ToolBox/ToolBoxInitial.dart';
import 'package:appkinsonFront/views/profiles/Patient/PatientProfile.dart';
import 'package:appkinsonFront/views/profiles/Patient/profileEdition/ProfileEditionPatient.dart';
import 'package:flutter/material.dart';

class RoutesPatient {
  //ruta para ir al home de un paciente
  toPatientHome(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => PatientHomePage()));
  }
//ruta para entrar a calendario de síntomas
  toCalendar(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => CalendarScreenView2()));
  }
//ruta para entrar al formulario de sintomas no motores
  toNoMotorSymptoms(BuildContext context, int idPatient) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => NoMotorSymptomsFormQ(
                  idPatient: idPatient,
                )));
  }
//ruta para entrar al formulario emocional
  toFeelsForm(BuildContext context, int idPatient) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => EmotionalFormQ(
                  idPatient: idPatient,
                )));
  }
//ruta pare entrar a la página de listado de medicinas
  toScheduleMedicines(BuildContext context, int idPatient) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => Medicines(
                  idPatient: idPatient,
                )));
  }
//ruta para entrar a la pantalla de notificaciones
  toNotifications(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => PatientNotifications()));
  }
//ruta para entrar a la pantalla de notificaciones remotas
  toRelationsRequest(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => RelationsRequest()));
  }
//ruta para entrar a ver el perfil de un paciente
  toPatientProfile(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MyHomePage1()));
  }
//ruta para ver información sobre el parkinson
  toAboutParkinson(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Information()));
  }
//ruta para la edición del perfil
  toPatientEditProfile(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ProfileEditionPatient()));
  }

  toSymptomsForm(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => symptomsFormQ()));
  }
//ruta para el formulario de sintomas no motores
  toSymptomsFormPatient(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => SymptomsFormPatient()));
  }
//ruta para entrar a activiades y juegos
  toToolbox(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => toolbox()));
  }
//ruta para entrar al juego
  toGame(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => CountDownTimer()));
  }
}
