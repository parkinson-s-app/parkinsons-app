import 'dart:convert';

import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/Medicines/medicines.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlarmAndMedicine {
  String title; // levodopa
  int quantity; // 1 or 2 dose 1
  int periodicityQuantity; // 8
  String periodicityType; // hour or day
  String idMedicine;
  TimeOfDay alarmTime;
  String dose; //mg pastilla
  int id;
  String medicine;
  /**
   * preguntas: todos los dias las dosis?
   * dosis como mg o ml son un dropdown o un input text?
   * preguntar si el cuidador puede cambiar cosas del medicamento y por qué es necesario(contra no tendremos informacion segura)
   * 
   */
  AlarmAndMedicine({
    this.title,
    this.quantity,
    this.periodicityQuantity,
    this.periodicityType,
    this.idMedicine,
    this.alarmTime,
    this.dose,
    this.id,
  });
}

class AlarmAndMedicinePage extends StatelessWidget {
  static const String _title = 'Alarmas de Medicinas';
  final int idPatient;

  AlarmAndMedicinePage({@required this.idPatient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: Column(
        children: <Widget>[
          ListAlarmsAndMedicinePatient(
            idPatient: idPatient,
          )
        ],
      ),
    );
  }
}

class ListAlarmsAndMedicine extends State<ListAlarmsAndMedicinePatient> {
  static List<AlarmAndMedicine> alarms;
  static List<String> medicinesString;
  TimeOfDay _time = TimeOfDay.now();
  String hora = '¡Escoge la hora!';
  List<Medicine> medicines = <Medicine>[];
  final int idPatient;
  String medicineSelected = "0";

  String title; // levodopa
  TextEditingController periodicityQuantity = new TextEditingController(); // 8
  TextEditingController quantity = new TextEditingController(); // 1 or 2 dose 1
  String periodicityType = 'Hora(s)'; // hour or day
  // String idMedicine;
  // TimeOfDay alarmTime;
  TextEditingController dose = new TextEditingController(); //mg pastilla
  int id;

  ListAlarmsAndMedicine(this.idPatient);
  // TODO fill medicines from db and alarms
  @override
  Widget build(BuildContext context) {
    //if (medicines.isNotEmpty) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Column(children: [
      SizedBox(
        height: 50,
      ),
      Center(child: dropdownMedicinesfilled()),
      SizedBox(
        height: 30,
      ),
      Row(
        children: [
          Text(
            "Hora Inicial",
            style: TextStyle(
                color: Colors.indigo, fontSize: 15, fontFamily: "Raleway2"),
          ),
          relojito(size, context)
        ],
      ),
      new TextField(
        decoration: new InputDecoration(labelText: "Dosis", hintText: '2'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ], // Only numbers can be entered
        controller: quantity,
      ),
      new TextField(
        decoration:
            new InputDecoration(labelText: "Tipo de Dosis", hintText: 'mg'),
        keyboardType: TextInputType.text, // Only numbers can be entered
        controller: dose,
      ),
      Row(
        children: [
          Text(
            "Tipo de periocidad",
            style: TextStyle(
                color: Colors.indigo, fontSize: 18, fontFamily: "Raleway2"),
          ),
          new DropdownButton<String>(
            value: periodicityType,
            items: <String>['Hora(s)', 'Dia(s)'].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (selected) {
              setState(() {
                periodicityType = selected;
              });
            },
          ),
        ],
      ),
      new TextField(
        decoration:
            new InputDecoration(labelText: "Periodicidad", hintText: '1'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ], // Only numbers can be entered
        controller: periodicityQuantity,
      ),
      Container(
          //height: 50,
          //margin: EdgeInsets.symmetric(horizontal: 50),
          child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        padding: EdgeInsets.symmetric(horizontal: 50),
        onPressed: () async {
          print('medicine: $medicineSelected');
          print('Hora: ${_time.hour}:${_time.minute}');
          print('Dosis: text ${quantity.text} !');
          print('Tipo period. $periodicityType');
          print('periodicidad  !${periodicityQuantity.text}!');
          print('Tipo de dosis ${dose.text}');
          String per = periodicityQuantity.text;
          int periodiciyNumb = int.tryParse(per) ?? -1;
          print('num: $periodiciyNumb!');
          print('aca1');
          AlarmAndMedicine alarmAndMedicine = new AlarmAndMedicine();
          alarmAndMedicine.alarmTime = _time;
          alarmAndMedicine.dose = dose.text;
          alarmAndMedicine.idMedicine = medicineSelected;
          alarmAndMedicine.periodicityQuantity = periodiciyNumb;
          alarmAndMedicine.quantity = int.tryParse(quantity.text) ?? (-1);
          alarmAndMedicine.periodicityType = periodicityType;
          //Aquí se agrega a la lista
          String res = await EndPoints()
              .saveAlarmsAndMedicines(alarmAndMedicine, idPatient);
          print('response save medicine: $res');
          var token = await Utils().getToken();
          //Navigator.pop(context);
          items = await EndPoints().getMedicinesAlarms(idPatient, token);
          RoutesPatient().toScheduleMedicines(context, idPatient);
        },
        color: Colors.blue,
        textColor: Colors.white,
        child: Text("Guardar", style: TextStyle(fontSize: 15)),
      )),
    ]));
    //}
    //return Scaffold();
  }

  Widget relojito(Size size, BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        onPressed: () async {
          _time = await showTimePicker(context: context, initialTime: _time);
          debugPrint(_time.toString());
          setState(() {
            hora = '${_time.hour}:${_time.minute}';
          });
        },
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey[200],
        //textColor: Colors.white,
        child: Text(
          hora,
          style: TextStyle(
            color: Colors.indigo,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  DropdownButton<String> dropdownMedicinesfilled() {
    print("consruyendo dropdown");
    print("longitud: " + medicines.length.toString());
    return DropdownButton<String>(
      value: medicineSelected,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          medicineSelected = newValue;
        });
      },
      items: medicines.map<DropdownMenuItem<String>>((Medicine medicine) {
        return DropdownMenuItem<String>(
          value: medicine.idMedicine.toString(),
          child: Text(medicine.name),
        );
      }).toList(),
    );
  }

  fillMedicinesMock() {
    List<Medicine> _medicines = <Medicine>[];
    Medicine med1, med2, med3;
    med1 = new Medicine();
    med2 = new Medicine();
    med3 = new Medicine();
    med1.idMedicine = 1;
    med1.name = "Paracetamol";
    med2.idMedicine = 2;
    med2.name = "aspirina";
    med3.name = "Seleccione una medicina";
    med3.idMedicine = 0;
    _medicines.add(med1);
    _medicines.add(med2);
    _medicines.add(med3);
    setState(() {
      medicines = _medicines;
      print(" medicens filled " + medicines.length.toString());
    });
  }

  fillMedicines() async {
    print(" llenando medicinas");
    List<Medicine> _medicines = <Medicine>[];
    Medicine med0 = new Medicine.filled("Seleccione una medicina", 0);
    _medicines.add(med0);
    // Medicine med0, med2, med3;
    var token = await Utils().getToken();
    String medicinesInBackJSON = await EndPoints().getMedicines(token);
    var medicinesInBack = json.decode(medicinesInBackJSON);
    for (var medicine in medicinesInBack) {
      print('med: ${medicine.toString()}');
      Medicine medicineAux = new Medicine();
      medicineAux.idMedicine = int.parse(medicine['ID'].toString());
      medicineAux.name = medicine['NAME'];
      print(
          'medicine fomatted: id:${medicineAux.idMedicine.toString()} name: ${medicineAux.name}');
      _medicines.add(medicineAux);
    }
    /*
    
    */
    setState(() {
      medicines = _medicines;
      print(" medicens filled " + medicines.length.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    fillMedicines();
  }
}

class ListAlarmsAndMedicinePatient extends StatefulWidget {
  final int idPatient;
  ListAlarmsAndMedicinePatient({key, this.idPatient}) : super(key: key);

  @override
  ListAlarmsAndMedicine createState() => ListAlarmsAndMedicine(this.idPatient);
}

class Medicine {
  String name;
  int idMedicine;
  Medicine();
  Medicine.filled(String name, int idMedicine) {
    this.name = name;
    this.idMedicine = idMedicine;
  }
}

getToken() async {
  String token = await Utils().getToken();
  return token;
}
