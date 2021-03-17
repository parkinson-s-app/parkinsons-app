import 'package:appkinsonFront/model/User.dart';
import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:appkinsonFront/views/Medicines/medicines.dart';
import 'package:appkinsonFront/views/Relations/DoctorPatients.dart';
import 'package:appkinsonFront/views/Relations/DoctorPatients.dart';
import 'package:flutter/material.dart';

import '../DoctorPatients.dart';

class ButtonGoMedicinesFromDoctor extends StatelessWidget {
  final int idPatient;

  ButtonGoMedicinesFromDoctor({@required this.idPatient});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          print('patient bboton ${idPatient.toString()}');
          items = await EndPoints()
              .getMedicinesAlarms(currentUser['id'].toString(), token);
          RoutesPatient().toScheduleMedicines(context, idPatient);
          //  RoutesDoctor().toPatientAlarmAndMedicine(context, idPatient);
        },
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey[50],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/medicines.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
