import 'dart:convert';
//import 'dart:html';
import 'dart:io';

import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:flutter/material.dart';
import '../model/User.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class EndPoints {
  String endpointBack = 'http://192.168.0.16:8000';

  Future<String> addUsers(User newUser) async {
    Map data2 = {
      'email': newUser.email,
      'password': newUser.password,
      'username': 'juan',
      'type': newUser.type
    };
    debugPrint(data2.toString());
    http.Response response =
        await http.post(this.endpointBack + '/api/registro', body: data2);

    //debugPrint(response.body);
    String i = response.body;
    return i;
    //data = json.decode(response.body);
  }

  Future<String> modifyUsersPhoto(User newUser, var tokenId, var token) async {
    var decodedToken = json.decode(token);

    debugPrint('hola2');
    String fileName = newUser.photo.path.split('/').last;
    debugPrint("File base name: $fileName");

    FormData formData = FormData.fromMap({
      'photo':
          await MultipartFile.fromFile(newUser.photo.path, filename: fileName),
    });

    Dio dio = new Dio();
    dio.options.headers["authorization"] = "Bearer " + decodedToken['token'];
    Response response = await dio.put(this.endpointBack + '/api/users/$tokenId',
        data: formData);
    /*http.Response response = await http.put(
        this.endpointBack + '/api/users/' + tokenId,
        body: data2,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + decodedToken['token']
        });*/

    debugPrint(response.toString());
    String i = response.toString();
    return i;
    //data = json.decode(response.body);
  }

  Future<String> modifyUsers(User newUser, var tokenId, var token) async {
    var decodedToken = json.decode(token);
    Map data2 = {
      //'email': newUser.email,
      //'password': newUser.password,
      'name': newUser.name,
      //'photo': newUser.photo
      //'type': newUser.type,
      //'image': newUser.photo
    };
    debugPrint('hola');
    http.Response response = await http.put(
        this.endpointBack + '/api/users/' + tokenId,
        body: data2,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + decodedToken['token']
        });

    //debugPrint(response.body);
    String i = response.body;
    return i;
    //data = json.decode(response.body);
  }

  Future<String> authUser(User authUser) async {
    Map data2 = {'email': authUser.email, 'password': authUser.password};
    http.Response response =
        await http.post(this.endpointBack + '/api/login', body: data2);
    debugPrint(data2.toString());
    String i = response.body;
    return i;
  }
}
