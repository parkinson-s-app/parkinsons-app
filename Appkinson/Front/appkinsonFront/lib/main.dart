import 'dart:convert';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/AboutUs/helpSupport.dart';
import 'package:appkinsonFront/views/Administrator/FormAddItem.dart';
import 'package:appkinsonFront/views/AlarmsAndMedicine/AlarmAndMedicinePage.dart';
import 'package:appkinsonFront/views/Calendar/CalendarScreenView2.dart';
import 'package:appkinsonFront/views/DataAnalisis/ReportScreen.dart';
import 'package:appkinsonFront/views/Game/countDownGame.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Admin/AdminHomePage.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Carer/CarerHomePage.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Doctor/DoctorHomePage.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Patient/PatientHomePage.dart';
import 'package:appkinsonFront/views/Medicines/medicines.dart';
import 'package:appkinsonFront/views/RelationRequest/relationsRequets.dart';
import 'package:appkinsonFront/views/Relations/interactionDoctorPatient.dart';
import 'package:appkinsonFront/views/ToolBox/ToolBoxInitial.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/initialization_settings.dart';
import 'package:nova_alarm_plugin/nova_alarm_plugin.dart';
import 'views/SymptomsFormPatient/SymptomsFormPatient.dart';
import 'package:appkinsonFront/local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'views/HomeInitial/HomePage.dart';
import 'views/Notifications/PatientNotifications.dart';
import 'views/HomeInitial/HomePage.dart';
import 'views/Login/LoginPage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'views/SymptomsFormDoctor/symptomsForm.dart';
import 'views/Calendar/CalendarScreen.dart';
import 'model/User.dart';
import 'constants/Constant.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    switch (task) {
      case TASK_SET_ALARMS:
        print("$TASK_SET_ALARMS was executed. inputData = $inputData");
        var tokenID = await Utils().getFromToken('id');
        List<AlarmAndMedicine> alarms =
            await EndPoints().getMedicinesAndAlarms(tokenID);
        var dateTime = new DateTime.now();
        for (var alarm in alarms) {
          int hour = alarm.alarmTime.hour;
          int minute = alarm.alarmTime.minute;
          var dateClock = new DateTime(
              dateTime.year, dateTime.month, dateTime.day, hour, minute);
          var clockId = int.tryParse(
                '${alarm.idMedicine.toString()}${alarm.id.toString()}',
              ) ??
              (-1);
          String time = (dateClock.millisecondsSinceEpoch).toString();
          bool result = await NovaAlarmPlugin.setClock(
            time,
            clockId,
            title: "title: ${alarm.title}",
            content:
                "Tomar ${alarm.quantity} ${alarm.dose} de ${alarm.medicine}",
          );
          print(' ${alarm.medicine} time: $time result: ${result.toString()}');
          await Future.delayed(Duration(seconds: 1));
        }
        print('finished');
        break;
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });
  String token = await Utils().getToken();
  if (token != null) {
    String type = await Utils().getFromToken('type');
    runApp(MyApp(type));
  } else {
    runApp(MyApp(null));
  }
}

class MyApp extends StatefulWidget {
  final String type;
  MyApp(this.type);
  @override
  _MyAppState createState() => _MyAppState(this.type);
}

class _MyAppState extends State<MyApp> {
  String token;
  final String type;
  _MyAppState(this.type);
  @override
  Widget build(BuildContext context) {
    if (type == 'Cuidador') {
      return MaterialApp(
          debugShowCheckedModeBanner: false, home: CarerHomePage());
    } else if (type == 'Doctor') {
      return MaterialApp(
          debugShowCheckedModeBanner: false, home: DoctorHomePage());
    } else if (type == 'Paciente') {
      return MaterialApp(
          debugShowCheckedModeBanner: false, home: PatientHomePage());
    } else if (type == 'Admin') {
      return MaterialApp(
          debugShowCheckedModeBanner: false, home: AdminHomePage());
    } else {
      return new MaterialApp(
          debugShowCheckedModeBanner: false, home: HomePage());
    }
  }
}
