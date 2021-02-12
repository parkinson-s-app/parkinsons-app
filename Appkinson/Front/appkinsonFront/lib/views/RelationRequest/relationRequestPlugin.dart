import 'dart:convert';
import 'dart:async';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/RelationRequest/relationRequest.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const simplePeriodicTask = "notification Relation Requets";
final List<Widget> listings = List<Widget>();
var response;

void showNotification(v, flp) async {
  var android = AndroidNotificationDetails(
      'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.High, importance: Importance.Max);
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android, iOS);
  await flp.show(0, 'Virtual intelligent solution', '$v', platform,
      payload: 'VIS \n $v');
}

void callbackDispatcher() {
  print('Entra!');
  debugPrint('Entra!');
  Workmanager.executeTask((task, inputData) async {
    debugPrint('Entra al exec!');

    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android, iOS);
    flp.initialize(initSetttings);

    //var response = await EndPoints().getRelationRequest(token);
    print(response);

    var responseJSON = json.decode(response);
    var resquests = json.decode(responseJSON);
    //for (var a = 0; a < resquests.length; a++) {
    // patients.add(codeList[a]['EMAIL']);
    // }
    //   showNotification('tienes notificaciones pendientes', flp);
    if (resquests != null && resquests.length > 0) {
      if (resquests.length > 1) {
        showNotification('tienes notificaciones pendientes', flp);
      } else if (resquests.length == 1) {
        showNotification('tienes una notificación pendientes', flp);
      } else {
        print("no hay mensaje");
      }
    }
    return Future.value(true);
  });
}

/*
Future<List<Widget>> getRelationsRequest() async {
  response = await EndPoints().getRelationRequest(token);
  var responseJSON = json.decode(response);
  for (int a = 0; a < responseJSON.length; a++) {
    listings.add(buildRelationRequestMessage(
        responseJSON[a]['EMAIL'], responseJSON[a]['TYPE']));
  }
}
*/

List<Widget> getListRelationsRequest() {
  return listings;
}

String getJson() {
  return response;
}
