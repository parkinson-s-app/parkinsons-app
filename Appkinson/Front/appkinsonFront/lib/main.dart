import 'package:flutter/material.dart';
import 'views/HomeInitial/HomePage.dart';
import 'views/Notifications/PatientNotifications.dart';
import 'views/HomeInitial/HomePage.dart';
import 'views/Login/LoginPage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'views/Calendar/CalendarScreen.dart';

import 'views/RelationRequest/relationRequest.dart';
import 'views/Relations/DoctorPatients.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //return new MaterialApp(
    //  debugShowCheckedModeBanner: false, home: CalendarScreen());
    return new MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());

    return new MaterialApp(debugShowCheckedModeBanner: false, home: relationRequest());
    //return new MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
