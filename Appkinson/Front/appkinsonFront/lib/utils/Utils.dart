import 'dart:convert';

import 'package:flutter/material.dart';

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
        payload = payload + "==";
        break;
    }

    var decode = utf8.decode(base64.decode(payload));
    debugPrint(decode);

    return json.decode(decode);
  }
}
