import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AlarmInfo {
  int id;
  String title;
  String dateString;
  Time alarmDateTimeDaily;
  DateTime alarmDateTime;
  bool isPending;

  AlarmInfo(
      {this.id,
        this.title,
        this.dateString,
        this.alarmDateTimeDaily,
        this.alarmDateTime,
        this.isPending,
      });

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
    id: json["id"],
    title: json["title"],
    alarmDateTime: DateTime.parse(json["alarmDateTime"]),
    isPending: json["isPending"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "alarmDateTimeDaily": alarmDateTimeDaily,
    "alarmDateTime": alarmDateTime.toIso8601String(),
    "isPending": isPending,
  };
  
}
