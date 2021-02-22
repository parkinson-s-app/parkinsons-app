import 'dart:convert';

import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:flutter/material.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'request.dart';

var response;

class Data {

   List<RelationRequest> relations = [
    RelationRequest(
        message: 'Carlos quiere ser tu Doctor'
    ),
    RelationRequest(
      message: 'María quiere cuidar de tí',
    ),
    RelationRequest(
      message: 'Andrés quiere cuidar de tí',
    ),
  ];

  var responseJSON = json.decode(response);
  //final List<RelationRequest> listings = List<RelationRequest>();
  RelationRequest relationRequestTemplate;

 /* Future<List<RelationRequest>> getRelationsRequest() async {

    response = await EndPoints().getRelationRequest(token);
    var responseJSON = json.decode(response);
    for (int a = 0; a < responseJSON.length; a++) {
      relationRequestTemplate.message = responseJSON[a]['EMAIL'] + "quiere ser tu" + responseJSON[a]['TYPE'];
      relations.add(relationRequestTemplate);
    }

  }*/

 List<RelationRequest> getListRelationsRequest() {
    return relations;
  }

}