import 'dart:convert';
import 'dart:io';

import 'package:appkinsonFront/model/SymptomsFormPatientM.dart';
import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/SymptomsFormPatient/SymptomsFormPatientQ5ON.dart';
import 'package:appkinsonFront/views/videoScreen/videoScreenDoctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

DateTime dateChoosed;
int count = 0;

class CalendarScreenView2Doctor extends StatefulWidget {
  @override
  _Calendar createState() => _Calendar();
}

TextEditingController _disqui = TextEditingController();
String state = 'on';
var color = Colors.green;
//File fileMedia;

List<Meeting> meetingsDoctor = new List<Meeting>();
String listPacientes;
var conta = 0;
int hora = 0;
var cont = 0;
String q2;
String q1;
int desface;
String idCurrent;
bool isLoading = false;

List<Color> _colors = <Color>[
  Colors.green,
  Colors.green[700],
  Colors.red,
  Colors.red[800]
];

var contCalendar = 0;

List<String> _onOff = <String>[
  'ON Bueno',
  'ON Muy Bueno',
  'OFF Malo',
  'OFF Muy Malo'
];
List<dynamic> _icon = <dynamic>[
  Icons.calendar_view_day,
  Icons.calendar_today_rounded
];
var currentMeeting;

class _Calendar extends State<CalendarScreenView2Doctor> {
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

  CalendarController _controller;

  @override
  void initState() {
    super.initState();
    currentMeeting = null;
    _controller = CalendarController();
    _controller.view = CalendarView.week;
    contCalendar = 0;
    //todos.add("Regular Colors");
    //todos.add("Power Coating");
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            new IconButton(
                icon: Icon(_icon[contCalendar]),
                color: Colors.black45,
                onPressed: () {
                  setState(() {
                    print('ey');
                    if (contCalendar == 0) {
                      _controller.view = CalendarView.day;
                      contCalendar = 1;
                    } else {
                      _controller.view = CalendarView.week;
                      contCalendar = 0;
                    }
                  });
                }),
          ],
          iconTheme: IconThemeData(color: Colors.grey),
          title: Text('Calendario',
              style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 20,
                  fontFamily: "Raleway2")),
          backgroundColor: Colors.white,
        ),
        body: SfCalendar(
          controller: _controller,
          //view: _controller.view,
          showNavigationArrow: true,
          headerHeight: 50,
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
                desface = currentMeeting['discrepancy'];
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
                        title: Text(
                          "Detalles",
                          textAlign: TextAlign.center,
                        ),
                        content: Form(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                              Row(
                                children: [
                                  Text('Estado:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                      icon: Icon(Icons.help_outlined,
                                          color: Colors.grey[500]),
                                      tooltip:
                                          'Son cambios del estado del paciente a lo largo del día. En fase o periodo ON hay un control satisfactorio de los síntomas y es posible una actividad motora normal. En cambio, en las fases OFF reaparecen los síntomas con una función motora alterada.')
                                ],
                              ),
                              Text(q1),
                              Divider(
                                thickness: 1,
                              ),
                              Row(
                                children: [
                                  Text('Disquinesias:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                      icon: Icon(Icons.help_outlined,
                                          color: Colors.grey[500]),
                                      tooltip:
                                          'son trastornos del movimiento que se caracterizan por un exceso de movimientos o por movimientos anormales e involuntarios')
                                ],
                              ),
                              Text(q2),
                              Divider(
                                thickness: 1,
                              ),
                              FlatButton(
                                height: 35,
                                minWidth: 220,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0)),
                                //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),

                                padding: EdgeInsets.symmetric(horizontal: 30),

                                //onPressed: _incrementColorIndex,
                                onPressed: () async {
                                  String token = await Utils().getToken();
                                  var video = await EndPoints()
                                      .getVideoUser(token, pathVideo);
                                  this.setState(() {
                                    fileMediaDoctor = video;
                                  });
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              VideoScreenDoctor()));
                                },

                                color: Colors.blue[500],
                                textColor: Colors.white,
                                child: Text('Ver Video'),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Row(
                                children: [
                                  Text('Desfase:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                      icon: Icon(Icons.help_outlined,
                                          color: Colors.grey[500]),
                                      tooltip:
                                          'Esta opción es para escoger cuánto tiempo después de la hora indicada se tomó el medicamento. Si fue a la hora establecida, puede continuar sin escoger nada.')
                                ],
                              ),
                              Text(desface.toString() +
                                  ' minutos de desfase en la toma de medicamento'),
                            ])),
                        /*actions: <Widget>[
                      FlatButton(
                          onPressed: () async {
                            SymptomsFormPatientM patientForm =
                                new SymptomsFormPatientM();

                            patientForm.q1 = _onOff[cont];
                            patientForm.q2 = _disqui.text;
                            patientForm.video = fileMedia;
                            patientForm.formDate = dateChoosed;
                            String id = await Utils().getFromToken('id');
                            String token = await Utils().getToken();
                            debugPrint('enviado');
                            var savedDone = await EndPoints()
                                .registerSymptomsFormPatient(patientForm,
                                    id, token);

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
                            meetings.add(m);
                            Navigator.pop(context);
                          },
                          child: Text("añadir"))
                    ],*/
                      );
                    });
                  });
              currentMeeting = null;
            } else {
              /*
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
                                  meetings.add(m);
                                  isLoading = false;
                                });
                                Navigator.pop(context);
                              },
                              child: Text("añadir"))
                          : Center(child: buildLoading())
                    ],
                  );
                });
              });*/
            }
            setState(() {
              if (conta == 8) {
                conta = 0;
              }
              conta++;
            });

            // RoutesPatient().toSymptomsFormPatient(context);
          },
          dataSource: MeetingDataSource(meetingsDoctor),
          monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ));
  }

  List<Meeting> _getDataSource() {
    meetingsDoctor = <Meeting>[];

    //final DateTime today = DateTime.now();
    if (dateChoosed.hour != null) {
      hora = dateChoosed.hour;
    }

    print(conta);
    final DateTime startTime = DateTime(
        dateChoosed.year, dateChoosed.month, dateChoosed.day, hora, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 1));

    if (conta == 1) {
      meetingsDoctor.add(
          Meeting('on', startTime, endTime, const Color(0xFF0F8644), false));
    }
    if (conta == 3) {
      meetingsDoctor.add(
          Meeting('on Bueno', startTime, endTime, Colors.green[900], false));
    }
    if (conta == 5) {
      meetingsDoctor
          .add(Meeting('off', startTime, endTime, Colors.red[400], false));
    }
    if (conta == 7) {
      meetingsDoctor
          .add(Meeting('off Malo', startTime, endTime, Colors.red[900], false));
    }

    return meetingsDoctor;
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
