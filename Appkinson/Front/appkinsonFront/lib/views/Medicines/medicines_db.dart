import 'package:appkinsonFront/views/Medicines/alarm.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

final String tableAlarm = 'alarms';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';

class MedicinesDB {
  static Database _database;
  static MedicinesDB _medicinesDB;


  MedicinesDB._createInstance();
  factory MedicinesDB() {
    if (_medicinesDB == null) {
      _medicinesDB = MedicinesDB._createInstance();
    }
    return _medicinesDB;
  }

   Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

   Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "alarm.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableAlarm ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer)
        ''');
      },
    );
    return database;
  }
  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    var result = await db.insert(tableAlarm, alarmInfo.toMap());
    print('result : $result');
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];

    var db = await this.database;
    var result = await db.query(tableAlarm);
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });

    return _alarms;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }
  

}