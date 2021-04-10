import 'dart:convert';
import 'dart:io';

import 'package:appkinsonFront/model/SymptomsFormPatientM.dart';
import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ5ON.dart';
import 'package:appkinsonFront/views/videoScreen/videoScreenCarer.dart';
import 'package:appkinsonFront/views/videoScreen/videoScreenDoctor.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:foldable_sidebar/foldable_sidebar.dart';
import '../sideMenus/CustomDrawerMenu.dart';

DateTime dateChoosed;
int count = 0;

class CalendarScreenView2 extends StatefulWidget {
  @override
  _CalendarScreenView2 createState() => _CalendarScreenView2();
}

class _CalendarScreenView2 extends State<CalendarScreenView2> {
  FSBStatus status;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FoldableSidebarBuilder(
            status: status,
            drawer: CustomDrawerMenu(),
            screenContents: CalendarScreenView2aux()),
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
            }),
      ),
    );
  }
}

class CalendarScreenView2aux extends StatefulWidget {
  @override
  _Calendar createState() => _Calendar();
}

TextEditingController _disqui = TextEditingController();
String state = 'on';
var color = Colors.green;
//File fileMedia;

List<Meeting> meetingPatient = new List<Meeting>();
String listPacientes;
var conta = 0;
int hora = 0;
var cont = 0;
String q2;
String q1;
String idCurrent;
bool isLoading = false;

List<Color> _colors = <Color>[
  Colors.green,
  Colors.green[700],
  Colors.red,
  Colors.red[800]
];

List<String> _onOff = <String>['on', 'on bueno', 'off', 'off malo'];
var currentMeeting;

class _Calendar extends State<CalendarScreenView2aux> {
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

  Widget buildLoading() {
    return AlertDialog(
      title: Text("Subiendo el video "),
      content: Form(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        new CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.teal[200]),
        ),
      ])),
    );
  }

  @override
  void initState() {
    super.initState();
    currentMeeting = null;
    //todos.add("Regular Colors");
    //todos.add("Power Coating");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SfCalendar(
      view: CalendarView.day,
      headerHeight: 100,
      onTap: (calendarTapDetails) {
        var sizeAppo = calendarTapDetails.appointments;
        print(sizeAppo.toString() + 'hola6');
        Meeting calen;
        String r;
        String pathVideo;
        if (sizeAppo.toString() != 'null') {
          calen = calendarTapDetails.appointments[0];
          r = calen.from.toString() + 'Z';
        }

        //print(calen.from);
        dateChoosed = calendarTapDetails.date;
        //var calen = calendarTapDetails.targetElement;
        //print(calen.index);
        //int horaPrueba = calen.index;
        //print(horaPrueba.toString());

        final DateTime probTime = DateTime(
            dateChoosed.year, dateChoosed.month, dateChoosed.day, 0, 0, 0);
        var convertedList = json.decode(listPacientes);
        for (var a = 0; a < convertedList.length; a++) {
          DateTime dateBd = DateTime.parse(convertedList[a]['formdate']);
          print(dateBd.toString() + 'hola');
          print(probTime.toString() + 'hola2');
          idCurrent = convertedList[a]['ID_PATIENT'].toString();
          //print();

          print(r);
          if (dateBd.toString() == r) {
            currentMeeting = convertedList[a];
            print(currentMeeting.toString());
            q2 = currentMeeting['Q2'];
            q1 = currentMeeting['Q1'];
            pathVideo = currentMeeting['pathvideo'].toString() + '.mp4';
            idCurrent = currentMeeting['ID_PATIENT'].toString();
          }
        }

        if (currentMeeting != null) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
                  currentMeeting = null;
                  return AlertDialog(
                    title: Text("Detalles:"),
                    content: Form(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
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
                      Text(q2),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),

                        padding: EdgeInsets.symmetric(horizontal: 30),

                        //onPressed: _incrementColorIndex,
                        onPressed: () async {
                          String token = await Utils().getToken();
                          var video =
                              await EndPoints().getVideoUser(token, pathVideo);
                          this.setState(() {
                            fileMediaCarer = video;
                          });
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => VideoScreenCarer()));
                        },

                        color: Colors.teal[200],
                        //textColor: Colors.white,
                        child: Text('ver video'),
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
                            String token = await Utils().getToken();
                            String id = await Utils().getFromToken('id');
                            var savedDone = await EndPoints()
                                .registerSymptomsFormPatient(
                                    patientForm, id, token);

                            debugPrint(savedDone.toString());

                            int hora = dateChoosed.hour;

                            final DateTime startTime = DateTime(
                                dateChoosed.year,
                                dateChoosed.month,
                                dateChoosed.day,
                                hora,
                                0,
                                0);
                            final DateTime endTime =
                                startTime.add(const Duration(hours: 1));
                            Meeting m = new Meeting(_onOff[cont], startTime,
                                endTime, _colors[cont], false);
                            debugPrint(m.eventName);
                            //setState(() {
                            meetingPatient.remove(m);
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.delete)),
                      FlatButton(
                          onPressed: null, child: Icon(Icons.edit_outlined))
                    ],
                  );
                });
              });
          currentMeeting = null;
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
                  currentMeeting = null;
                  return AlertDialog(
                    title: Text("llenado:"),
                    content: Form(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
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
                      !isLoading
                          ? FlatButton(
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

                                setState(() {
                                  isLoading = true;
                                });

                                String token = await Utils().getToken();
                                var savedDone = await EndPoints()
                                    .registerSymptomsFormPatient(
                                        patientForm, idCurrent, token);

                                int hora = dateChoosed.hour;

                                final DateTime startTime = DateTime(
                                    dateChoosed.year,
                                    dateChoosed.month,
                                    dateChoosed.day,
                                    hora,
                                    0,
                                    0);
                                final DateTime endTime =
                                    startTime.add(const Duration(hours: 1));
                                Meeting m = new Meeting(_onOff[cont], startTime,
                                    endTime, _colors[cont], false);
                                debugPrint(m.eventName);
                                //setState(() {

                                debugPrint(savedDone.toString());

                                this.setState(() {
                                  meetingPatient.add(m);
                                  isLoading = false;
                                });
                                Navigator.pop(context);
                              },
                              child: Text("añadir"))
                          : Center(child: buildLoading())
                    ],
                  );
                });
              });
        }
        //dateChoosed = calendarTapDetails.date;

        //meetings = _getDataSource();
        setState(() {
          if (conta == 8) {
            conta = 0;
          }
          conta++;
        });
      },
      dataSource: MeetingDataSource(meetingPatient),
      monthViewSettings: MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
    ));
  }

  List<Meeting> _getDataSource() {
    meetingPatient = <Meeting>[];

    if (dateChoosed.hour != null) {
      hora = dateChoosed.hour;
    }

    print(conta);
    final DateTime startTime = DateTime(
        dateChoosed.year, dateChoosed.month, dateChoosed.day, hora, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 1));

    if (conta == 1) {
      meetingPatient.add(
          Meeting('on', startTime, endTime, const Color(0xFF0F8644), false));
    }
    if (conta == 3) {
      meetingPatient.add(
          Meeting('on Bueno', startTime, endTime, Colors.green[900], false));
    }
    if (conta == 5) {
      meetingPatient
          .add(Meeting('off', startTime, endTime, Colors.red[400], false));
    }
    if (conta == 7) {
      meetingPatient
          .add(Meeting('off Malo', startTime, endTime, Colors.red[900], false));
    }

    return meetingPatient;
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
