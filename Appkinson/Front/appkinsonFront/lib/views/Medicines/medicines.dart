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
  @override
  void initState() {
    super.initState();
  }
  final key = GlobalKey<AnimatedListState>();
  final int idPatient;
  _MedicinesState(this.idPatient);
  //List<AlarmInfo> items;
  DateTime _alarmTime;
  String _alarmTimeString;

  //AlarmInfo alarm;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Alarmas de Medicamentos"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.contact_support_rounded),
              color: Colors.white,
              onPressed: () {
                information(context);
              }),
          ],
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
          onPressed: () async {
            print('otro idp ${idPatient.toString()}');
            int size = items.length;
            AlarmAndMedicine result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AlarmAndMedicinePage(idPatient: idPatient)),
              );
              debugPrint("tamaño " + size.toString());
              if(size!= 0){
                insertItem(0, result);
              }else{
                insertItem(0, result);
              }
              

            
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
    debugPrint("banderita" + item.medicine.toString());
    items.insert(index, item);
    key.currentState.insertItem(index);
  }

  void removeItem(int index) {
    //EndPoints().deleteAlarm(index.toString(), getToken(), getId());
    print("id: " + items[index].id.toString());
    EndPoints().deleteAlarm(items[index].id.toString(), idPatient);
    final item = items.removeAt(index);
    key.currentState.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
  }
}

information(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) =>
        _buildPopupDialog(context),
    barrierDismissible: true
  );
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: Text(
      "El botón “+” sirve para crear una nueva alarma de medicamento",
      ),
  );
}