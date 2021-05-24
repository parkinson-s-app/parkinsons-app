import 'dart:convert';
import 'dart:io';

import 'package:appkinsonFront/main.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/AlarmsAndMedicine/AlarmAndMedicinePage.dart';
import 'package:flutter/material.dart';
import 'package:nova_alarm_plugin/nova_alarm_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;
import 'package:appkinsonFront/constants/Constant.dart';

const TOKEN_KEY = 'token';
const TOKEN_TASK = 'backgroundtask';

class Utils {
  Map tokenDecoder(var token) {
    debugPrint('bruh');

    var lista = token.split(".");
    var payload = lista[1];

    switch (payload.length % 4) {
      case 1:
        break;
      case 2:
        payload = payload + "==";
        break;
      case 3:
        payload = payload + "=";
        break;
    }

    var decode = utf8.decode(base64.decode(payload));
    debugPrint(decode);

    return json.decode(decode);
  }

  Future<void> saveToken(String token) async {
    print('token to save: $token');
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN_KEY, token);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(TOKEN_KEY)) {
      return prefs.getString(TOKEN_KEY);
    }
    return null;
  }

  Future<String> getFromToken(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(TOKEN_KEY)) {
      String token = prefs.getString(TOKEN_KEY);
      Map tokenDecoded = this.tokenDecoder(token);
      return tokenDecoded[key].toString();
    }
    return null;
  }

  Future<void> setBackgroundTask() async {
    print('save task was set');
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(TOKEN_TASK, true);

    /**------------- */
  }

  Future<void> removeBackgroundTask() async {
    print('unset task');
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(TOKEN_TASK);
    prefs.remove(TOKEN_KEY);
    Workmanager.cancelAll();
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(TOKEN_KEY);
  }

  Future<bool> isSetBackgroundTask() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(TOKEN_TASK)) {
      return prefs.getBool(TOKEN_TASK);
    } else {
      return false;
    }
  }

  void initWorkmanager() {
    Workmanager.initialize(
        callbackDispatcher, // The top level function, aka callbackDispatcher
        isInDebugMode:
            false // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
        );
  }

  Future<void> setTaskGetAlarms() async {
    print('setting alarms task');
    DateTime before = DateTime.now();
    DateTime after;
    print('Hour: ${before.hour}');
    if (before.hour < 18) {
      after = new DateTime(before.year, before.month, before.day, 17, 22);
    } else {
      after = new DateTime(before.year, before.month, before.day + 1, 10);
    }
    print('minutes: ${after.difference(before).inMinutes.toString()}');
    Workmanager.registerPeriodicTask(
      TASK_SET_ALARMS,
      TASK_SET_ALARMS,
      initialDelay:
          Duration(seconds: 10), //minutes: after.difference(before).inMinutes),
      frequency: Duration(days: 1),
    );
    await setBackgroundTask();
  }
}
