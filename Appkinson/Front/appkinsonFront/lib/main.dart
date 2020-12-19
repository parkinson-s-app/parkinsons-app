import 'package:appkinsonFront/views/profiles/Patient/PatientProfile.dart';
import 'package:flutter/material.dart';
import 'views/HomeDifferentUsers/Admin/AdminHomePage.dart';
import 'views/HomeDifferentUsers/Doctor/DoctorHomePage.dart';
import 'views/HomeDifferentUsers/Patient/PatientHomePage.dart';
import 'views/HomeDifferentUsers/Patient/PatientHomePage.dart';
import 'views/HomeInitial/HomePage.dart';
import 'views/Notifications/PatientNotifications.dart';
import 'views/HomeInitial/HomePage.dart';
import 'views/HomeInitial/HomePage.dart';
import 'views/Login/LoginPage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
    //return new MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
