import 'package:flutter/material.dart';

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

class ListAlarmsAndMedicinePatient extends StatefulWidget {
  final int idPatient;
  ListAlarmsAndMedicinePatient({key, this.idPatient}) : super(key: key);

  @override
  ListAlarmsAndMedicine createState() => ListAlarmsAndMedicine(this.idPatient);
}

class ListAlarmsAndMedicine extends State<ListAlarmsAndMedicinePatient> {
  static List<AlarmAndMedicine> alarms;
  List<Medicine> medicines = <Medicine>[];
  static List<String> medicinesString;
  final int idPatient;
  String medicineSelected = "-1";
  ListAlarmsAndMedicine(this.idPatient);
  // TODO fill medicines from db and alarms
  fillMedicines() async {
    print(" llenando medicinas");
    List<Medicine> _medicines = <Medicine>[];
    List<String> _medicinesString = <String>[];
    Medicine med1, med2, med3;
    med1 = new Medicine();
    med2 = new Medicine();
    med3 = new Medicine();
    med1.idMedicine = 1;
    med1.name = "Paracetamol";
    med2.idMedicine = 2;
    med2.name = "aspirina";
    med3.name = "Seleccione una medicina";
    med3.idMedicine = -1;
    _medicines.add(med1);
    _medicines.add(med2);
    _medicines.add(med3);
    _medicinesString.add(med1.name);
    _medicinesString.add(med2.name);
    setState(() {
      medicines = _medicines;
      medicinesString = _medicinesString;
      print(" medicens filled " + medicines.length.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    fillMedicines();
  }

  @override
  Widget build(BuildContext context) {
    //if (medicines.isNotEmpty) {
    return Center(child: dropdownMedicinesfilled());
    //}
    //return Scaffold();
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
}

class AlarmAndMedicine {
  String name;
  String quantity; // 1 or 2 dose
  int periodicityQuantity; // 8
  String periodicityType; // hour or day
  String idMedicine;
  TimeOfDay time;
}

class Medicine {
  String name;
  int idMedicine;
}
