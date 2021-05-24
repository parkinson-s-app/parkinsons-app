import 'package:appkinsonFront/views/Calendar/CalendarScreenView2Doctor.dart';
import 'package:appkinsonFront/views/AlarmsAndMedicine/AlarmAndMedicinePage.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Doctor/DoctorHomePage.dart';
import 'package:appkinsonFront/views/Relations/DoctorPatientAdd.dart';
import 'package:appkinsonFront/views/Relations/DoctorPatients.dart';
import 'package:appkinsonFront/views/Relations/interactionDoctorPatient.dart';
import 'package:appkinsonFront/views/Report/Widget_Chart_Line.dart';
import 'package:appkinsonFront/views/Report/Widget_Chart_Pie.dart';
import 'package:appkinsonFront/views/Report/listReports.dart';
import 'package:appkinsonFront/views/Report/reportConfig.dart';
import 'package:appkinsonFront/views/Report/Widget_Chart_Serie.dart';
import 'package:appkinsonFront/views/profiles/Doctor/DoctorProfile.dart';
import 'package:appkinsonFront/views/profiles/Doctor/profileEdition/ProfileEditionDoctor.dart';
import 'package:flutter/material.dart';

class RoutesDoctor {
  //ruta hacia el home de un doctor
  toDoctorHome(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => DoctorHomePage()));
  }
 //ruta para la visualización de un calendario desde el perfil de un doctor
  toCalendarDoctor(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => CalendarScreenView2Doctor()));
  }
//ruta hacia la configuración para el intervalo de creación de las gráficas
  toReportConfigPage(BuildContext context, int idPatient) {
    Navigator.push(context,
        new MaterialPageRoute(
            builder: (context) => ReportConfigPage(
                  idPatient: idPatient,
                )));
  }
//ruta para agregar un nuevo paciente
  toAddUser(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => DoctorPatientsAdd()));
  }

  toReportPage(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => WidgetChartPie()));
  }
//ruta para ir a la lista de los reportes posibles a generar
  toListReportPage(BuildContext context, int idPatient, List<DateTime> picked ) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ListReportPage(
          idPatient: idPatient,
          picked: picked,
        )));
  }
//ruta intermedia desde un doctor hacia un paciente 
  toInteractionDoctorPatient(BuildContext context, int idPatient) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => InteractionDoctorPatient(
                  idPatient: idPatient,
                )));
  }
//ruta para la edición de un perfil de doctor
  toDoctorProfile(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MyHomePage2()));
  }
//ruta hacía la pantalla de listar pacientes
  toPatientList(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => DoctorPatients()));
  }

  toDoctorEditProfile(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ProfileEditionDoctor()));
  }
//ruta para la configuración de una alarma de medicina
  toPatientAlarmAndMedicine(BuildContext context, int idPatient) {
    print('otro idpat ${idPatient.toString()}');
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => AlarmAndMedicinePage(
                  idPatient: idPatient,
                )));
  }
//ruta para visualizar gráficas de tipo torta
  toReportChartPie(BuildContext context, String id, var dataPie, String titulo, String descripcion) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => WidgetChartPie(
                  id: id,
                  dataPie: dataPie,
                  tituloGrafica: titulo,
                  descripcion: descripcion
                )));
  }
//ruta para visualizar las gráfias de tipo linea
  toReportChartLine(BuildContext context, var id, var dataLine, String titulo, String ejex, String ejey,
  String description, String dataDescription) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => WidgetChartLine(
                  id: id,
                  dataLine: dataLine,
                  titulo: titulo,
                  ejex: ejex,
                  ejey: ejey,
                  description: description,
                  dataDescription: dataDescription,
                )));
  }
//ruta para visualizar las gráficas de tipo barras
  toReportChartSerie(BuildContext context, var id, var dataLine, String titulo, var colors,
  String ejex, String ejey, String description, String dataDescription) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => WidgetChartSerie(
                  id: id,
                  dataSerie: dataLine,
                  titulo: titulo, 
                  colors: colors,
                  ejex: ejex,
                  ejeY: ejey,
                  description: description,
                  dataDescription: dataDescription,
                )));
  }
}
