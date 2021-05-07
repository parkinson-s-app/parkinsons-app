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
      body: ListAlarmsAndMedicinePatient(
        idPatient: idPatient,
      ),
    );
  }
}

class ListAlarmsAndMedicine extends State<ListAlarmsAndMedicinePatient> {
  static List<AlarmAndMedicine> alarms;
  static List<String> medicinesString;
  //String dropdownValue = 'Inserte el Tipo de Dosis';
  TimeOfDay _time = TimeOfDay.now();
  String hora = 'Escoja la Hora';
  List<Medicine> medicines = <Medicine>[];
  final int idPatient;
  String medicineSelected;
  bool isPeriodic =true;
  String title; // levodopa
  TextEditingController periodicityQuantity = new TextEditingController(); // 8
  TextEditingController quantity = new TextEditingController(); // 1 or 2 dose 1
  String periodicityType = 'Hora(s)';
  String dose; // hour or day
  // String idMedicine;
  // TimeOfDay alarmTime;
  TextEditingController dose2 = new TextEditingController(); //mg pastilla
  int id;

  ListAlarmsAndMedicine(this.idPatient);
  // TODO fill medicines from db and alarms
  @override
  Widget build(BuildContext context) {
    //if (medicines.isNotEmpty) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
          padding: EdgeInsets.all(22),
          child: Column(children: [
            Text(
              "Medicamentos: ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: "Raleway2",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Center(child: dropdownMedicinesfilled()),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(15)),
              child: DropdownButton<String>(
                isExpanded: false,
                style: TextStyle(color: Colors.grey, fontSize: 18),
                underline: SizedBox(),
                value: dose,
                items: <String>['1 Uno', '2 Dos' , '3 Tres' , '1/4 Un cuarto', '1/2 Media', '3/4 Tres cuartos'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                hint: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Inserte la cantidad",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
                onChanged: (selected) {
                  setState(() {
                    dose = selected;
                  });
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  child: Text("Escoger por periodicidad"),
                  
                  onPressed: () {
                    setState(() {
                      this.isPeriodic = false;
                    });
                  },
                  style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (this.isPeriodic == false) return Colors.blue;
                      return Colors.grey;
                    },
                    ),
                    elevation: MaterialStateProperty.all(8),
                  ),
                
                ),
                ),
                SizedBox(
                  width: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                child:  ElevatedButton(
                  
                  child: Text("Escoger hora manual"),
                  onPressed: () {
                    setState(() {
                      this.isPeriodic = true;
                    });
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (this.isPeriodic == true) return Colors.blue;
                      return Colors.grey;
                    },
                    ),
                    elevation: MaterialStateProperty.all(8),
                  ),
                )
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ! isPeriodic ? 
            Column(
              children: <Widget>[
              Row(
              children: <Widget>[
                Text(
                  "Tipo de Periocidad: ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "Raleway2",
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: DropdownButton<String>(
                    isExpanded: false,
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                    underline: SizedBox(),
                    value: periodicityType,
                    items: <String>['Hora(s)', 'Día(s)'].map((String value) {
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
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
                  decoration: new InputDecoration(
                      labelText: "Inserte la Periodicidad",
                      contentPadding: EdgeInsets.symmetric(horizontal: 2),
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                  controller: periodicityQuantity,
                ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Hora de inicio: ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "Raleway2",
                      fontWeight: FontWeight.bold),
                ),),
                relojito(size, context)
              ],
            ), ]): Column(
                children: <Widget>[
                  Text(
                  "Agregar hora manualmente : ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "Raleway2",
                      fontWeight: FontWeight.bold),
                ),
                relojito(size, context)
                ],
                
            ),
            SizedBox(
              height: 30,
            ),

            Container(
                //height: 50,
                //margin: EdgeInsets.symmetric(horizontal: 50),
                child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
              padding: EdgeInsets.symmetric(horizontal: 50),
              onPressed: () async {
                print('medicine: $medicineSelected');
                print('Hora: ${_time.hour}:${_time.minute}');
                print('Tipo period. $periodicityType');
                print('periodicidad  !${periodicityQuantity.text}!');
                print('Tipo de dosis ${dose}');
                
                AlarmAndMedicine alarmAndMedicine = new AlarmAndMedicine();
                if(isPeriodic){
                  print("null");
                  alarmAndMedicine.periodicityQuantity = 0; //perioricidad
                  alarmAndMedicine.periodicityType = null; 
                }else{
                  String per = periodicityQuantity.text;
                  int periodiciyNumb = int.tryParse(per) ?? -1;
                  alarmAndMedicine.periodicityQuantity = periodiciyNumb; //perioricidad
                  alarmAndMedicine.periodicityType = periodicityType; 
                }
                alarmAndMedicine.alarmTime = _time; //alarma
                alarmAndMedicine.dose = dose; // cantidad
                alarmAndMedicine.idMedicine = medicineSelected; //nombre medicina
                debugPrint("medicina: ");
                print("medicina" + alarmAndMedicine.idMedicine);
                print(alarmAndMedicine.periodicityQuantity);
                print(alarmAndMedicine.periodicityType);
                print(alarmAndMedicine.dose);
                print(alarmAndMedicine.alarmTime);
                //tipo perioricidad

                //Aquí se agrega a la lista
                String res = await EndPoints()
                    .saveAlarmsAndMedicines(alarmAndMedicine, idPatient);
                print('response save medicine: $res');
                var token = await Utils().getToken();
                //Navigator.pop(context);
                items = await EndPoints().getMedicinesAlarms(idPatient, token);
                AlarmAndMedicine nuevo = items[items.length-1];
                Navigator.pop(context, nuevo);
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("Guardar", style: TextStyle(fontSize: 15)),
            )),
          ])),
    );
    //}
    //return Scaffold();
  }

  Widget relojito(Size size, BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(12),
      child: FlatButton(
        minWidth: 140,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        onPressed: () async {
          _time = await showTimePicker(context: context, initialTime: _time);
          debugPrint(_time.toString());
          setState(() {
            hora = _time.format(context);
          });
        },
        //padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey[200],
        //textColor: Colors.white,
        child: Text(
          hora,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Container dropdownMedicinesfilled() {
    print("consruyendo dropdown");
    print("longitud: " + medicines.length.toString());
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15)),
        child: DropdownButton<String>(
          isExpanded: true,
          value: medicineSelected,
          elevation: 16,
          style: TextStyle(color: Colors.grey, fontSize: 20),
          underline: SizedBox(),
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
          hint: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Seleccione un medicamento",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
        ));
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
    med3.name = "Seleccione una Medicina";
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
