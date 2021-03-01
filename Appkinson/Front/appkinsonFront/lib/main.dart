import 'dart:convert';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Calendar/CalendarScreenView2.dart';
import 'package:appkinsonFront/views/DataAnalisis/ReportScreen.dart';
import 'package:appkinsonFront/views/Medicines/medicines.dart';
import 'package:appkinsonFront/views/RelationRequest/relationsRequets.dart';
import 'package:appkinsonFront/views/Relations/interactionDoctorPatient.dart';
import 'package:appkinsonFront/views/ToolBox/ToolBoxInitial.dart';
import 'package:flutter/material.dart';
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
    //return new MaterialApp(debugShowCheckedModeBanner: false, home: relationRequest());
    //return new MaterialApp(debugShowCheckedModeBanner: false, home: ReportScreen());
    // return new MaterialApp(
    //     debugShowCheckedModeBanner: false, home: SymptomsFormPatient());
  }
}
