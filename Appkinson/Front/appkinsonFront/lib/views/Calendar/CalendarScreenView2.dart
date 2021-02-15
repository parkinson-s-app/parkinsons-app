import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

DateTime dateChoosed;
int count = 0;
class CalendarScreenView2 extends StatefulWidget {
  @override
  _Calendar createState() => _Calendar();
}

List<Meeting> meetings = new List<Meeting>();

class _Calendar extends State<CalendarScreenView2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
      view: CalendarView.day,
      /*onTap: (calendarTapDetails) {
        dateChoosed = calendarTapDetails.date;
        RoutesPatient().toSymptomsFormPatient(context);
      },*/
      onTap: (calendarTapDetails){
        dateChoosed = calendarTapDetails.date;
        setState(() {
         // print(dateChoosed.hour);
          print(dateChoosed.hour);
         count++;
         if(count == 3){
           count = 0;
         }
        });
      },
      dataSource: MeetingDataSource(_getDataSource()),
      monthViewSettings: MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
    ));
  }

  List<Meeting> _getDataSource() {
    meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    DateTime startTime;
    DateTime endTime;
    if(dateChoosed != null ){
      startTime = DateTime(today.year, today.month, today.day, dateChoosed.hour, 0, 0);
      endTime = startTime.add(const Duration(hours: 1));
      print("AQUI2");
      print(dateChoosed.hour);
      if(count ==1){
        meetings.add(Meeting(
            'ON', startTime, endTime, Colors.green, false));
      }
      if(count == 2){
        meetings.add(Meeting(
            'OFF', startTime, endTime, Colors.red, false));
      }
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
