import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/AlarmsAndMedicine/AlarmAndMedicinePage.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:appkinsonFront/views/Medicines/alarm.dart';
import 'package:appkinsonFront/views/Medicines/alarm_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:appkinsonFront/main.dart';


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
        backgroundColor: Colors.teal,
        appBar: AppBar(
          title: Text("Médicamentos"),
          actions:<Widget> [
            new IconButton(
                icon: Icon(Icons.settings),
                color: Colors.black45,
                onPressed: () {
                  //onSaveAlarm();
                  //deleteAlarm(alarm.id);
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
            Container(
              padding: EdgeInsets.all(5),
              child: buildInsertButton(this.idPatient),
            ),
          ],
        ),
      );

  Widget buildItem(item, int index, Animation<double> animation) =>
      AlarmItemWidget(
        item: item,
        animation: animation,
        onClicked: () => removeItem(index),
      );


  Widget buildInsertButton(int idPatient) => RaisedButton(
        child: Icon(Icons.add, size: 50, color: Colors.lightGreen,),
        color: Colors.white,
        onPressed: () {
          print('otro idp ${idPatient.toString()}');
          RoutesDoctor().toPatientAlarmAndMedicine(context, idPatient);
         // insertItem(items.length , Data.alarmas.first);
         /* _alarmTimeString =
              DateFormat('HH:mm').format(DateTime.now());
          showModalBottomSheet(
            useRootNavigator: true,
            context: context,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setModalState) {
                  return Container(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        FlatButton(
                          onPressed: () async {
                           // alarm.title = DateTime.now().toString();
                            var selectedTime =
                            await showTimePicker(
                              context: context,
                              initialTime:
                              TimeOfDay.now(),
                            );
                            if (selectedTime != null) {
                              final now = DateTime.now();
                              var selectedDateTime =
                              DateTime(
                                  now.year,
                                  now.month,
                                  now.day,
                                  selectedTime.hour,
                                  selectedTime
                                      .minute);
                              _alarmTime =
                                  selectedDateTime;
                              setModalState(() {
                                _alarmTimeString =
                                    DateFormat('HH:mm')
                                        .format(
                                        selectedDateTime);
                                //alarm.title = _alarmTimeString;
                                //print(alarm.title);
                              });
                              //alarm.title = _alarmTimeString;
                            }
                          },
                          child: Text(
                            _alarmTimeString,
                            style:
                            TextStyle(fontSize: 32),
                          ),
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                           // alarm.title = _alarmTimeString;
                            AlarmInfo alarm = new AlarmInfo();
                            alarm.title = _alarmTimeString;
                            alarm.id = id;
                            insertItem(items.length, alarm );

                            },
                          icon: Icon(Icons.alarm),
                          label: Text('Agregar'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );*/
        },
      );
  
  void insertItem(int index, AlarmAndMedicine item) {
    //alarm.title = "Hola";
   // alarm.title = _alarmTimeString;
   // DateTime scheduleAlarmDateTime;
   // if (_alarmTime.isAfter(DateTime.now()))
   //   scheduleAlarmDateTime = _alarmTime;
   // else
   //   scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));

    //scheduleAlarm(scheduleAlarmDateTime, item);
   // id = id+1;
   // EndPoints().sendAlarm(item.id.toString(), item.title, scheduleAlarmDateTime.toString() , 'true' , token, currentUser['id'].toString());
   // item.title = _alarmTimeString;
    items.insert(index, item);
    key.currentState.insertItem(index);
    Navigator.pop(context);
  }

  void removeItem(int index) {
    EndPoints().deleteAlarm(index.toString(), token, currentUser['id'].toString());
    final item = items.removeAt(index);

    key.currentState.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
  }
}
