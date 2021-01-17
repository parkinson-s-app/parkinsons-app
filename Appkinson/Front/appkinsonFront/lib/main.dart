import 'dart:convert';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:flutter/material.dart';
import 'package:appkinsonFront/local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'views/HomeInitial/HomePage.dart';
import 'model/User.dart';

List<User> patients = [];

void callbackDispatcher() {
  Workmanager.executeTask((taskName, inputData) async {
    LocalNotification.Initializer();
    LocalNotification.ShowOneTimeNotification(DateTime.now());
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager.initialize(callbackDispatcher);
  await Workmanager.registerPeriodicTask("test_workertask", "test_workertask",
      inputData: {"data1": "value1", "data2": "value2"},
      frequency: Duration(minutes: 15),
      initialDelay: Duration(minutes: 1));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //return new MaterialApp(
    //  debugShowCheckedModeBanner: false, home: CalendarScreen());
    return new MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());

    //return new MaterialApp(debugShowCheckedModeBanner: false, home: relationRequest());
    //return new MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}