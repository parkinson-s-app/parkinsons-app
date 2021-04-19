import 'dart:io';

class SymptomsFormPatientM {
  String q1;
  String q2;
  int discrepancy;
  DateTime formDate;
  File video;

  SymptomsFormPatientM(
      {this.q1, this.q2, this.formDate, this.video, this.discrepancy});
}
