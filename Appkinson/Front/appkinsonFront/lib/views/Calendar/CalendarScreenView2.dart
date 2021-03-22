import 'dart:io';

import 'package:appkinsonFront/model/SymptomsFormPatientM.dart';
import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ5ON.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

DateTime dateChoosed;
int count = 0;

class CalendarScreenView2 extends StatefulWidget {
  @override
  _Calendar createState() => _Calendar();
}

TextEditingController _disqui = TextEditingController();
String state = 'on';
var color = Colors.green;
//File fileMedia;

List<Meeting> meetings = new List<Meeting>();
var conta = 0;
int hora = 0;
var cont = 0;

List<Color> _colors = <Color>[
  Colors.green,
  Colors.green[700],
  Colors.red,
  Colors.red[800]
];

List<String> _onOff = <String>['on', 'on bueno', 'off', 'off malo'];

class _Calendar extends State<CalendarScreenView2> {
  void _incrementColorIndex() {
    setState(() {
      print(cont);
      if (cont < _colors.length - 1) {
        cont++;
      } else {
        cont = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SfCalendar(
      view: CalendarView.day,
      headerHeight: 100,
      onTap: (calendarTapDetails) {
        dateChoosed = calendarTapDetails.date;

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  title: Text("Llenado:"),
                  content: Form(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),

                      padding: EdgeInsets.symmetric(horizontal: 30),

                      //onPressed: _incrementColorIndex,
                      onPressed: () {
                        setState(() {
                          _incrementColorIndex();
                        });
                      },

                      color: _colors[cont],
                      //textColor: Colors.white,
                      child: Text(_onOff[cont]),
                      /*() => {
                        //print(cont);
                        _incrementColorIndex()
                      },*/
                      // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
                    ),
                    Row(
                      children: [
                        Text('Disquinesias:'),
                        IconButton(
                            icon: Icon(Icons.announcement_rounded,
                                color: Colors.yellow[900]),
                            tooltip:
                                'son trastornos del movimiento que se caracterizan por un exceso de movimientos o por movimientos anormales e involuntarios')
                      ],
                    ),
                    TextFormField(
                      controller: _disqui,
                      validator: (value) {
                        return value.isNotEmpty ? null : "Invalido";
                      },
                      decoration: InputDecoration(
                          hintText: "Ej: 'hoy tuve un movimiento raro"),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),

                      padding: EdgeInsets.symmetric(horizontal: 30),

                      //onPressed: _incrementColorIndex,
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    SymptomsFormPatientQ5ON()));
                      },

                      color: Colors.teal[200],
                      //textColor: Colors.white,
                      child: Text('hacer video(opcional)'),
                      /*() => {
                        //print(cont);
                        _incrementColorIndex()
                      },*/
                      // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
                    ),
                  ])),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () async {
                          SymptomsFormPatientM patientForm =
                              new SymptomsFormPatientM();

                          patientForm.q1 = _onOff[cont];
                          patientForm.q2 = _disqui.text;
                          //patientForm.q3 = BringAnswer2Off().send();
                          //patientForm.q4 = BringAnswerPatientQ3().send();
                          //patientForm.q5 = BringAnswerPatientQ4().send();
                          patientForm.video = fileMedia;
                          patientForm.formDate = dateChoosed;

                          debugPrint('enviado');
                          var savedDone = await EndPoints()
                              .registerSymptomsFormPatient(patientForm,
                                  currentUser['id'].toString(), token);

                          debugPrint(savedDone.toString());

                          int hora = dateChoosed.hour;

                          final DateTime startTime = DateTime(dateChoosed.year,
                              dateChoosed.month, dateChoosed.day, hora, 0, 0);
                          final DateTime endTime =
                              startTime.add(const Duration(hours: 1));
                          Meeting m = new Meeting(_onOff[cont], startTime,
                              endTime, _colors[cont], false);
                          debugPrint(m.eventName);
                          //setState(() {
                          meetings.add(m);
                          Navigator.pop(context);
                        },
                        child: Text("añadir"))
                  ],
                );
              });
            });
        //dateChoosed = calendarTapDetails.date;

        //meetings = _getDataSource();
        setState(() {
          if (conta == 8) {
            conta = 0;
          }
          conta++;
        });

        // RoutesPatient().toSymptomsFormPatient(context);
      },
      dataSource: MeetingDataSource(meetings),
      monthViewSettings: MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
    ));
  }

  List<Meeting> _getDataSource() {
    meetings = <Meeting>[];

    //final DateTime today = DateTime.now();
    if (dateChoosed.hour != null) {
      hora = dateChoosed.hour;
    }

    print(conta);
    final DateTime startTime = DateTime(
        dateChoosed.year, dateChoosed.month, dateChoosed.day, hora, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 1));

    if (conta == 1) {
      meetings.add(
          Meeting('on', startTime, endTime, const Color(0xFF0F8644), false));
    }
    if (conta == 3) {
      meetings.add(
          Meeting('on Bueno', startTime, endTime, Colors.green[900], false));
    }
    if (conta == 5) {
      meetings.add(Meeting('off', startTime, endTime, Colors.red[400], false));
    }
    if (conta == 7) {
      meetings
          .add(Meeting('off Malo', startTime, endTime, Colors.red[900], false));
    }

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
