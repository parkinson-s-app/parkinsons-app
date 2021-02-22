import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:appkinsonFront/constants/Constant.dart';
import 'package:appkinsonFront/model/EmotionsForm.dart';
import 'package:appkinsonFront/model/SymptomsForm.dart';
import 'package:appkinsonFront/model/SymptomsFormPatientM.dart';
import 'package:flutter/material.dart';
import '../model/User.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class EndPoints {

  Future<String> addUsers(User newUser) async {
    Map data2 = {
      'email': newUser.email,
      'password': newUser.password,
      'username': 'juan',
      'type': newUser.type
    };
    debugPrint(data2.toString());
    debugPrint(endpointBack + addUserUrl);
    http.Response response =
        await http.post(endpointBack + addUserUrl, body: data2);

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
    dio.options.headers["authorization"] = jwtkey + decodedToken['token'];
    Response response =
        await dio.post(endpointBack + '/api/users/$tokenId', data: formData);
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
    http.Response response = await http.post(
        endpointBack + modifyNameOfUserURL + tokenId,
        body: data2,
        headers: {
          HttpHeaders.authorizationHeader: jwtkey + decodedToken['token']
        });

    //debugPrint(response.body);
    String i = response.body;
    return i;
    //data = json.decode(response.body);
  }

  Future<String> authUser(User authUser) async {
    debugPrint("entro");
    Map data2 = {'email': authUser.email, 'password': authUser.password};
    http.Response response =
        await http.post(endpointBack + authURL, body: data2);
    //debugPrint(data2.toString());
    debugPrint("-----");
    debugPrint(response.body);
    String body = response.body;
    return body;
  }

  Future<String> sendResponseRelation(
      String answer, String type, String requesterId) async {
    Map data2 = {
      'Answer': answer,
      'RequesterType': type,
      'RequesterId': requesterId
    };
    http.Response response =
        await http.post(endpointBack + '/api/relation/response', body: data2);
    debugPrint(data2.toString());
    String i = response.body;
    return i;
  }

  Future<String> linkUser(String emailUser, var tokenID, var token) async {
    //Map data2 = {'email': authUser.email, 'password': authUser.password};
    var codeToken = json.decode(token);
    http.Response lista = await http.get(endpointBack + linkUserUnrelatedURL,
        headers: {
          HttpHeaders.authorizationHeader: jwtkey + codeToken['token']
        });
    //http.Response response =
    debugPrint(lista.body);
    String i = lista.body;
    String addedUser;

    var codeList = json.decode(i);
    for (var a = 0; a < codeList.length; a++) {
      if (emailUser == codeList[a]['EMAIL'].toString()) {
        http.Response added = await http.post(
            endpointBack + linkUserURL + codeList[a]['ID_USER'].toString(),
            headers: {
              HttpHeaders.authorizationHeader: "Bearer " + codeToken['token']
            });
        debugPrint(added.body);
        addedUser = codeList[a]['EMAIL'];
      }
    }
    return addedUser;
  }

  Future<String> linkUserCarer(String emailUser, var tokenID, var token) async {
    //Map data2 = {'email': authUser.email, 'password': authUser.password};
    var codeToken = json.decode(token);
    http.Response lista = await http
        .get(endpointBack + '/api/carer/patients/unrelated', headers: {
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
            endpointBack + '/api/relate/' + codeList[a]['ID_USER'].toString(),
            headers: {
              HttpHeaders.authorizationHeader: "Bearer " + codeToken['token']
            });
        debugPrint(added.body);
        addedUser = codeList[a]['EMAIL'];
      }
    }
    return addedUser;
  }

  Future<String> linkedUser(var tokenID, var token) async {
    //Map data2 = {'email': authUser.email, 'password': authUser.password};
    var codeToken = json.decode(token);
    http.Response lista = await http.get(endpointBack + linkUserRelatedURL,
        headers: {
          HttpHeaders.authorizationHeader: jwtkey + codeToken['token']
        });
    //http.Response response =
    debugPrint(lista.body);
    String i = lista.body;
    var codeList = json.decode(i);
    List<String> patients = [];
    for (var a = 0; a < codeList.length; a++) {
      patients.add(codeList[a]['EMAIL']);
    }
    return i;
  }

  Future<List<String>> linkedUserCarer(var tokenID, var token) async {
    //Map data2 = {'email': authUser.email, 'password': authUser.password};
    var codeToken = json.decode(token);
    http.Response lista = await http
        .get(endpointBack + '/api/carer/patients/related', headers: {
      HttpHeaders.authorizationHeader: jwtkey + codeToken['token']
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

  Future<bool> registerSymptomsForm(
      SymptomsForm form, var tokenID, var token) async {
    bool success = false;

    String fileName = form.video.path.split('/').last;
    var decodedToken = json.decode(token);
    var video;

    if (form.video != null) {
      video = await MultipartFile.fromFile(form.video.path, filename: fileName);
    } else {
      video = null;
    }

    //http.Response response =
    Map<String, dynamic> formMap = {
      'q1': form.q1,
      'q2': form.q2,
      'q3': form.q3,
      'q4': form.q4,
      'q5': form.q5,
      /*
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
      */
      'date': form.date,
      'video': video,
    };

    FormData formData = new FormData.fromMap(formMap);
    Dio dio = new Dio();
    dio.options.headers["authorization"] = jwtkey + decodedToken['token'];
    Response response = await dio.post(
        endpointBack + '/api/users/$tokenID/symptomsForm',
        data: formData);
    debugPrint("formulario enviado");
    return success;
  }

Future<bool> registerEmotionsForm(
      EmotionsForm form, var tokenID, var token) async {
    bool success = false;

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
      'q17': form.q17,
      'q18': form.q18,
      'q19': form.q19,
      'q20': form.q20,
      'q21': form.q21,
      'q22': form.q22,
      'q23': form.q23,
      'q24': form.q24,
      'q25': form.q25,
      'q26': form.q26,
      'q27': form.q27,
      'q28': form.q28,
      'q29': form.q29,
      'q30': form.q30,
      'date': form.date.toString(),
    };
    var jsonBody =  jsonEncode(formMap);
    var codeToken = json.decode(token);
    debugPrint(jsonBody);
    http.Response lista = await http.post(endpointBack + '/api/patient/$tokenID/emotionalFormPatient', headers: {
      HttpHeaders.authorizationHeader: jwtkey + codeToken['token'], 'Content-Type': 'application/json; charset=UTF-8'
    },body: jsonBody);
    
    debugPrint(lista.body);
    if(lista.body == "OK"){
      success = true;
    }
    return success;
  }
/*
  Future<String> getRelationRequest(var token) async {
    //Map data2 = {'email': authUser.email, 'password': authUser.password};
    var codeToken = json.decode(token);
    http.Response lista = await http
        .get(endpointBack + '/api/patient/relationRequest', headers: {
      HttpHeaders.authorizationHeader: jwtkey + codeToken['token']
    });
    //http.Response response =
    debugPrint(lista.body);
    String relationsRequest = lista.body;
    return relationsRequest;
  }


  Future<String> registerSymptomsFormPatient(
      SymptomsFormPatientM form, var tokenID, var token) async {
    bool success = false;

    String fileName = form.video.path.split('/').last;
    var decodedToken = json.decode(token);
    var video;

    if (form.video != null) {
      video = await MultipartFile.fromFile(form.video.path, filename: fileName);
    } else {
      video = null;
    }

    //http.Response response =
    Map<String, dynamic> formMap = {
      'q1': form.q1,
      'q2': form.q2,
      'q3': form.q3,
      'q4': form.q4,
      'q5': form.q5,
      'formDate': form.formDate,
      'video': video,
    };

    FormData formData = new FormData.fromMap(formMap);

    Dio dio = new Dio();
    dio.options.headers["authorization"] = jwtkey + decodedToken['token'];
    Response response = await dio.post(
        endpointBack + '/api/users/$tokenID/symptomsFormPatient',
        data: formData);
    debugPrint(response.statusMessage);
    return response.statusMessage;
  }

  Future<String> getSymptomsFormPatient(var token, var tokenID) async {
    //Map data2 = {'email': authUser.email, 'password': authUser.password};
    var codeToken = json.decode(token);
    http.Response lista = await http.get(
        endpointBack + '/api/patients/$tokenID/symptomsFormPatient',
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + codeToken['token']
        });
    //http.Response response =
    debugPrint(lista.body);
    String relationsRequest = lista.body;
    return relationsRequest;
  }

}
