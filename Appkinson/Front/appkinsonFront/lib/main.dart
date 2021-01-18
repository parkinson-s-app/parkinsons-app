import 'package:flutter/material.dart';
import 'SymptomsFormPatient/SymptomsFormPatient.dart';
import 'views/HomeInitial/HomePage.dart';
import 'views/Notifications/PatientNotifications.dart';
import 'views/HomeInitial/HomePage.dart';
import 'views/Login/LoginPage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'views/Calendar/CalendarScreen.dart';
import 'views/RelationRequest/relationRequestPlugin.dart';
import 'views/Relations/DoctorPatients.dart';
import 'package:workmanager/workmanager.dart';

Future<void> main() async {
  debugPrint('main!');
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager.initialize(callbackDispatcher,
      isInDebugMode:
          true); //to true if still in testing lev turn it to false whenever you are launching the app
  await Workmanager.registerPeriodicTask("5", simplePeriodicTask,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      frequency: Duration(minutes: 15), //when should it check the link
      initialDelay:
          Duration(minutes: 1), //duration before showing the notification
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return new MaterialApp(
    //  debugShowCheckedModeBanner: false, home: CalendarScreen());
    //return new MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());

    //return new MaterialApp(debugShowCheckedModeBanner: false, home: relationRequest());
    return new MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());

    // return new MaterialApp(
    //     debugShowCheckedModeBanner: false, home: SymptomsFormPatient());
  }
}
