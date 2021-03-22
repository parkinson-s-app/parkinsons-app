
import 'package:appkinsonFront/views/Medicines/alarm.dart';
import 'package:appkinsonFront/views/Medicines/alarm_item_widget.dart';
import 'package:appkinsonFront/views/Medicines/dataAlarm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'package:foldable_sidebar/foldable_sidebar.dart';
import '../sideMenus/CustomDrawerMenu.dart';

/*
class Medicines extends StatefulWidget {
  @override
  _Medicines createState() => _Medicines();
}

class _Medicines extends State<Medicines> {
  
  FSBStatus status;
  
  @override
  Widget build(BuildContext context) {
  return SafeArea(
      child: Scaffold(
        body: FoldableSidebarBuilder(status: status , drawer: CustomDrawerMenu(), screenContents: Medicines0()),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue[800],
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                status = status == FSBStatus.FSB_OPEN
                    ? FSBStatus.FSB_CLOSE
                    : FSBStatus.FSB_OPEN;
              });
            }
        ),
      ),
    ); 
  }
}*/

class Medicines extends StatefulWidget {
  _MedicinesState0 createState() => _MedicinesState0();
}

class _MedicinesState0 extends State<Medicines> {
  final key = GlobalKey<AnimatedListState>();
  final items = List.from(Data.alarmas);
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
              child: buildInsertButton(),
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


  Widget buildInsertButton() => RaisedButton(
        child: Icon(Icons.add, size: 50, color: Colors.lightGreen,),
        color: Colors.white,
        onPressed: () {
         // insertItem(items.length , Data.alarmas.first);
          _alarmTimeString =
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
                            insertItem(items.length, Data.alarmas.first, _alarmTimeString );

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
          );
        },
      );
  

  void insertItem(int index, AlarmInfo item, String _alarmTimeString) {
    AlarmInfo alarm;
    //alarm.title = "Hola";
   // alarm.title = _alarmTimeString;
    item.title = _alarmTimeString;
    items.insert(index, item);
    key.currentState.insertItem(index);
    Navigator.pop(context);
  }

  void removeItem(int index) {
    final item = items.removeAt(index);

    key.currentState.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
  }
}
