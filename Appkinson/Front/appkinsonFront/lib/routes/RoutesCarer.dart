import 'package:appkinsonFront/views/Calendar/CalendarScreenView2Carer.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Carer/CarerHomePage.dart';
import 'package:appkinsonFront/views/Relations/CarerPatients.dart';
import 'package:appkinsonFront/views/Relations/interactionCarerPatient.dart';
import 'package:appkinsonFront/views/ToolBox/ToolBoxInitial.dart';
import 'package:appkinsonFront/views/ToolBox/ToolBoxInitialCarer.dart';
import 'package:appkinsonFront/views/profiles/Carer/CarerProfle.dart';
import 'package:appkinsonFront/views/profiles/Carer/profileEdition/ProfileEditionCarer.dart';
import 'package:flutter/material.dart';
import '../views/Relations/DoctorPatientAdd.dart';

class RoutesCarer {
  //ruta hacia el home del cuidador
  toCarerHome(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => CarerHomePage()));
  }
 //ruta hacia el perfil del cuidador 
  toCarerProfile(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MyHomePage3()));
  }
 //ruta para la edición y visulización del calendario correspondiente a un paciente
  toCalendarCarer(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => CalendarScreenView2Carer()));
  }
 //ruta para listar los pacientes
  toPatientList(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => CarerPatients()));
  }
 //ruta para agregar un paciente
  toAddUser(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => DoctorPatientsAdd()));
  }
 //ruta para la edición de un perfil de cuidador
  toCarerEditProfile(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ProfileEditionCarer()));
  }
 //ruta hacia la pantalla intermedia de interacción con un paciente
  toInteractionCarerPatient(BuildContext context, int idPatient) {
    print('patient pantalla intermedia ${idPatient.toString()}');
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => InteractionCarerPatient(
                  idPatient: idPatient,
                )));
  }
 //ruta hacia e toolbox desde un cuidador
  toToolbox(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => toolbox()));
  }
}
