import 'dart:convert';
//import 'dart:html';
import 'dart:io';

import 'package:appkinsonFront/model/SymptomsForm.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:flutter/material.dart';
import '../model/User.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class EndPoints {
  String endpointBack = 'http://192.168.20.25:8000';

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
    Response response = await dio
        .post(this.endpointBack + '/api/users/$tokenId', data: formData);
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

  Future<String> linkUser(String emailUser, var tokenID, var token) async {
    //Map data2 = {'email': authUser.email, 'password': authUser.password};
    var codeToken = json.decode(token);
    http.Response lista = await http
        .get(this.endpointBack + '/api/doctor/patients/unrelated', headers: {
      HttpHeaders.authorizationHeader: "Bearer " + codeToken['token']
    });
    //http.Response response =
    debugPrint(lista.body);
    String i = lista.body;
    String addedUser;

    var codeList = json.decode(i);
    for (var a = 0; a < codeList.length; a++) {
      if (emailUser == codeList[a]['EMAIL'].toString()) {
        http.Response added = await http.post(
            this.endpointBack +
                '/api/relate/' +
                codeList[a]['ID_USER'].toString(),
            headers: {
              HttpHeaders.authorizationHeader: "Bearer " + codeToken['token']
            });
        debugPrint(added.body);
        addedUser = codeList[a]['EMAIL'];
      }
    }
    return addedUser;
  }

  Future<List<String>> linkedUser(var tokenID, var token) async {
    //Map data2 = {'email': authUser.email, 'password': authUser.password};
    var codeToken = json.decode(token);
    http.Response lista = await http
        .get(this.endpointBack + '/api/doctor/patients/related', headers: {
      HttpHeaders.authorizationHeader: "Bearer " + codeToken['token']
    });
    //http.Response response =
    debugPrint(lista.body);
    String i = lista.body;
    var codeList = json.decode(i);
    List<String> patients = [];
    for (var a = 0; a < codeList.length; a++) {
      patients.add(codeList[a]['EMAIL']);
    }
    return patients;
  }

  Future<bool> registerSymptomsForm(SymptomsForm form, var tokenID, var token) async {
    bool success = false;

    String fileName = form.video.path.split('/').last;
    var decodedToken = json.decode(token);

    //http.Response response =
    Map<String, dynamic> formMap = {
      'q1': form.q1,
      'q2': form.q2,
      'q3': form.q3,
      'q4': form.q4,
      'q5': form.q5,
      'q6': form.q6,
      'q7': form.q7,
      'q8': form.q8,
      'q9': form.q9,
      'q10': form.q10,
      'q11': form.q11,
      'q12': form.q12,
      'q13': form.q13,
      'q14': form.q14,
      'q15': form.q15,
      'q16': form.q16,
      'date': form.date,
      'video': await MultipartFile.fromFile(form.video.path, filename: fileName),
    };

    FormData formData = new FormData.fromMap(formMap);
    Dio dio = new Dio();
    dio.options.headers["authorization"] = "Bearer " + decodedToken['token'];
    Response response = await dio
        .post(this.endpointBack + '/api/users/$tokenID/symptomsForm', data: formData);

    return success;
  }

}
