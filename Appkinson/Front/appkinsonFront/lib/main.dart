import 'dart:convert';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/AboutUs/helpSupport.dart';
import 'package:appkinsonFront/views/Administrator/FormAddItem.dart';
import 'package:appkinsonFront/views/AlarmsAndMedicine/AlarmAndMedicinePage.dart';
import 'package:appkinsonFront/views/Calendar/CalendarScreenView2.dart';
import 'package:appkinsonFront/views/DataAnalisis/ReportScreen.dart';
import 'package:appkinsonFront/views/Game/countDownGame.dart';
import 'package:appkinsonFront/views/Medicines/medicines.dart';
import 'package:appkinsonFront/views/RelationRequest/relationsRequets.dart';
import 'package:appkinsonFront/views/Relations/interactionDoctorPatient.dart';
import 'package:appkinsonFront/views/ToolBox/ToolBoxInitial.dart';
import 'package:flutter/material.dart';
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
import 'package:appkinsonFront/constants/Constant.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
/*
List<User> patients = [];

void callbackDispatcher() {
  Workmanager.executeTask((taskName, inputData) async {
    LocalNotification.Initializer();
    LocalNotification.ShowOneTimeNotification(DateTime.now());
    // var response = await EndPoints().getRelationRequest(token);
    // print(response);

    // var responseJSON = json.decode(response);
    // var resquests = json.decode(responseJSON);
    //for (var a = 0; a < resquests.length; a++) {
    // patients.add(codeList[a]['EMAIL']);
    // }
    //   showNotification('tienes notificaciones pendientes', flp);
    // if (resquests != null && resquests.length > 0) {
    //   if (resquests.length > 1) {
    LocalNotification.ShowOneTimeNotification(DateTime.now());
    //   } else if (resquests.length == 1) {
    //     LocalNotification.ShowOneTimeNotification(DateTime.now());
    //   } else {
    //     print("no hay mensaje");
    //   }
    // }
    return Future.value(true);
  });
}
*/
void callbackDispatcher() {
    Workmanager.executeTask((task, inputData) async {
      // print("Native called background task: $backgroundTask"); //simpleTask will be emitted here.
      switch (task) {
        case TASK_SET_ALARMS:
          print("$TASK_SET_ALARMS was executed. inputData = $inputData");
          // const ip = '18.222.20.36';
          // const port = '9000';
          // const endpointBack = 'http://$ip:$port';
          // const jwtkey = "Bearer ";
          // var token =
          //     'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBhY2llbnRlQG1haWwuY29tIiwidHlwZSI6IlBhY2llbnRlIiwiaWQiOjEsImlhdCI6MTYxNjMxMTA0MX0.v-4rxSlePPwlcF7QVl1qXl1FGmzcsmGIatj7cDMtqyaPIrh3Es0MM1jtymR5rLgdrjxOlckVx3qQFba3n1Dmww';

          // http.Response lista = await http.get(
          //     endpointBack + '/api/patient/relationRequest',
          //     headers: {HttpHeaders.authorizationHeader: jwtkey + token});
          
          //_________________
          
          // var tokenID = await Utils().getFromToken('id');
          // List<AlarmAndMedicine> alarms =
          //     EndPoints().getMedicinesAndAlarms(int.parse(tokenID))
          //         as List<AlarmAndMedicine>;

          // // print('Lista: ${lista.body}');
          // var dateTime = new DateTime.now();
          // for (var alarm in alarms) {
          //   int hour = alarm.alarmTime.hour;
          //   int minute = alarm.alarmTime.minute;
          //   var dateClock = new DateTime(
          //       dateTime.year, dateTime.month, dateTime.day, hour, minute);
          //   var clockId = int.parse(
          //       '${alarm.idMedicine.toString()}${alarm.id.toString()}');
          //   String time = (dateClock.millisecondsSinceEpoch).toString();
          //   bool result = await NovaAlarmPlugin.setClock(
          //     time,
          //     clockId,
          //     title: "title: ${alarm.title}",
          //     content:
          //         "Tomar ${alarm.quantity} ${alarm.dose} de ${alarm.medicine}",
          //   );
          //   print(
          //       ' ${alarm.medicine} time: $time result: ${result.toString()}');
          //   await Future.delayed(Duration(seconds: 1));
          // }
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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return new MaterialApp(
    //  debugShowCheckedModeBanner: false, home: CalendarScreen());
    //return new MaterialApp(debugShowCheckedModeBanner: false, home: toolbox());
    return new MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
    // return new MaterialApp(debugShowCheckedModeBanner: false, home: AlarmAndMedicinePage( idPatient: 0,));
    //return new MaterialApp(debugShowCheckedModeBanner: false, home: CalendarScreenView2());
    //  return new MaterialApp(debugShowCheckedModeBanner: false, home: CountDownTimer());
    //return new MaterialApp(debugShowCheckedModeBanner: false, home: relationRequest());
    //return new MaterialApp(debugShowCheckedModeBanner: false, home: ReportScreen());
    // return new MaterialApp(
    //     debugShowCheckedModeBanner: false, home: SymptomsFormPatient());
  }
}
