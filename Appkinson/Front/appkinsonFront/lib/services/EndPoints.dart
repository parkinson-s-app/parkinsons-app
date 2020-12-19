import 'package:flutter/material.dart';
import '../model/User.dart';
import 'package:http/http.dart' as http;
import '../views/Login/LoginPage.dart';
import '../views/Login/LoginPage.dart';

class EndPoints {
  Future<String> addUsers(User newUser) async {
    Map data2 = {
      'email': newUser.email,
      'password': newUser.password,
      'username': 'juan',
      'type': newUser.type
    };
    debugPrint(data2.toString());
    http.Response response =
        await http.post('http://192.168.0.19:8000/api/registro', body: data2);

    //debugPrint(response.body);
    String i = response.body;
    return i;

    //data = json.decode(response.body);
  }

  Future<String> authUser(User authUser) async {
    Map data2 = {'email': authUser.email, 'password': authUser.password};
    http.Response response =
        await http.post('http://192.168.0.19:8000/api/login', body: data2);
    debugPrint(data2.toString());
    String i = response.body;
    return i;
  }
}
