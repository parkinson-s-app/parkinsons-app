import 'dart:io';
//Modelo usado para manejar los datos de formulario de del estado de ánimo ligado a un paciente
class SymptomsFormPatientM {
  String q1;
  String q2;
  int discrepancy;
  DateTime formDate;
  File video;

  SymptomsFormPatientM(
      {this.q1, this.q2, this.formDate, this.video, this.discrepancy});
}
