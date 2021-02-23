import 'package:appkinsonFront/views/Notifications/NotificationPlugin.dart';
import 'package:flutter/material.dart';

class PatientNotifications extends StatefulWidget {
  @override
  _PatientNotifications createState() => _PatientNotifications();
}

class _PatientNotifications extends State<PatientNotifications> {
  bool valueSymptoms = true;
  bool valueMedicines = true;
  bool valueCheerUp = true;
  bool valueMedicalAppointment = false;
  @override
  void initState() {
    super.initState();
    notificationPlugin
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recordatorios'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          new SwitchListTile(
            value: valueSymptoms,
            onChanged: onChangeValueSymptoms,
            activeColor: Colors.amberAccent,
            secondary: new Icon(Icons.sick),
            title: new Text(
              'Sintomas',
              style: new TextStyle(fontSize: 20.0),
            ),
            subtitle:
            new Text('¡Recuerda registrar tus síntomas todos los días!'),
          ),
          SizedBox(
            height: 30,
          ),
          new SwitchListTile(
            value: valueMedicines,
            onChanged: onChangeValueMedicine,
            activeColor: Colors.amberAccent,
            secondary: new Icon(Icons.medical_services),
            title: new Text(
              'Medicamentos',
              style: new TextStyle(fontSize: 20.0),
            ),
            subtitle:
            new Text('¡Recuerda tomarte los medicamentos todos los días!'),
          ),
          SizedBox(
            height: 30,
          ),
          new SwitchListTile(
            value: valueCheerUp,
            onChanged: onChangeValueCheerUp,
            activeColor: Colors.amberAccent,
            secondary: new Icon(Icons.emoji_emotions_sharp),
            title: new Text(
              'Estado de ánimo',
              style: new TextStyle(fontSize: 20.0),
            ),
            subtitle:
            new Text('¡Recuerda registrar tu estado de ánimo cada semana!'),
          ),
          SizedBox(
            height: 30,
          ),
          new SwitchListTile(
            value: valueMedicalAppointment,
            onChanged: onChangeValueMedicalAppointment,
            activeColor: Colors.amberAccent,
            secondary: new Icon(Icons.accessibility_new),
            title: new Text(
              'Cita de control',
              style: new TextStyle(fontSize: 20.0),
            ),
            subtitle:
            new Text('¡Recuerda la cita médica para tu próximo control!'),
          ),
          //ButtonAddReminder();
        ],
      ),
    );
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {}
  onNotificationClick(String payload) {}

  Widget buildSettingsMedicalAppointment(){
    return AlertDialog(
      scrollable: true,
      title: Text('Configuración de tu cita'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Fecha',
                  icon: Icon(Icons.account_box),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Hora',
                  icon: Icon(Icons.email),
                ),
              ),
            ],
          ),
        ),),);
  }

  void onChangeValueSymptoms(bool value) async {
    setState(() {
      valueSymptoms = value;
    });
    if (value == true) {
      await notificationPlugin.showNotification();
    }
    /*else{
      await notificationPlugin.cancelNotification();
    }*/
  }

  void onChangeValueMedicine(bool value) async {
    setState(() {
      valueMedicines = value;
    });
    if (value == true) {
      await notificationPlugin.showDailyAtTime();
    }
  }

  void onChangeValueCheerUp(bool value) async {
    setState(() {
      valueCheerUp = value;
    });
    if (value == true) {
      await notificationPlugin.showWeeklyAtDayTime();
    }
  }

  void onChangeValueMedicalAppointment(bool value) async {
    setState(() {
      valueMedicalAppointment = value;
    });
    buildSettingsMedicalAppointment();
    if (value == true) {
      buildSettingsMedicalAppointment();
      await notificationPlugin.scheduleNotification();
    }
  }
}