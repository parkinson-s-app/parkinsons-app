import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/AlarmsAndMedicine/AlarmAndMedicinePage.dart';
import 'package:appkinsonFront/views/Medicines/alarm.dart';
import 'package:appkinsonFront/views/Medicines/alarm_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:appkinsonFront/main.dart';

import 'package:foldable_sidebar/foldable_sidebar.dart';
import '../sideMenus/CustomDrawerMenu.dart';

class Medicines extends StatefulWidget {
  final int idPatient;

  Medicines({Key key, this.idPatient}) : super(key: key);

  _MedicinesState createState() => _MedicinesState(this.idPatient);
}

var items;
var id = 0;

class _MedicinesState extends State<Medicines> {
  final key = GlobalKey<AnimatedListState>();
  final int idPatient;
  _MedicinesState(this.idPatient);
  //List<AlarmInfo> items;
  DateTime _alarmTime;
  String _alarmTimeString;

  //AlarmInfo alarm;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text("Alarmas de Medicamentos"),
          actions: <Widget>[],
        ),
        body: Column(
          children: [
            Expanded(
              child: AnimatedList(
                key: key,
                initialItemCount: items.length,
                itemBuilder: (context, index, animation) =>
                    buildItem(items[index], index, animation),
              ),
            ),
            /*
            Container(
              padding: EdgeInsets.all(5),
              child: buildInsertButton(this.idPatient),
            ),
            */
          ],
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
          backgroundColor: Colors.blue[800],
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            //addUser();
            print('otro idp ${idPatient.toString()}');
            RoutesDoctor().toPatientAlarmAndMedicine(context, idPatient);
          },
        ),
        //  floatingActionButton:  ,
      );

  Widget buildItem(item, int index, Animation<double> animation) =>
      AlarmItemWidget(
        item: item,
        animation: animation,
        onClicked: () => removeItem(index),
      );

  Widget buildInsertButton(int idPatient) => RaisedButton(
        child: Icon(
          Icons.add,
          size: 50,
          color: Colors.lightGreen,
        ),
        color: Colors.white,
        onPressed: () {
          print('otro idp ${idPatient.toString()}');
          RoutesDoctor().toPatientAlarmAndMedicine(context, idPatient);
        },
      );

  void insertItem(int index, AlarmAndMedicine item) {
    items.insert(index, item);
    key.currentState.insertItem(index);
    Navigator.pop(context);
  }

  void removeItem(int index) {
    EndPoints().deleteAlarm(index.toString(), getToken(), getId());
    final item = items.removeAt(index);

    key.currentState.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
  }
}

getId() async {
  String id = await Utils().getFromToken('id');
  return id;
}

getToken() async {
  String token = await Utils().getToken();
  return token;
}
