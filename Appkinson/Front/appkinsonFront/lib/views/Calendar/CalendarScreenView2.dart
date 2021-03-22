import 'package:appkinsonFront/routes/RoutesPatient.dart';
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
        body: FoldableSidebarBuilder(status: status , drawer: CustomDrawerMenu(), screenContents: CalendarScreenView2aux()),
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
}

class CalendarScreenView2aux extends StatefulWidget {
  @override
  _Calendar createState() => _Calendar();
}

List<Meeting> meetings = new List<Meeting>();
var conta = 0;
int hora = 0;

class _Calendar extends State<CalendarScreenView2aux> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
      view: CalendarView.day,
      headerHeight: 100,
      onTap: (calendarTapDetails) {
        //dateChoosed = calendarTapDetails.date;
        dateChoosed = calendarTapDetails.date;
        meetings = _getDataSource();
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
