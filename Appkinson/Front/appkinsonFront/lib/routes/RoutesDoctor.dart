import 'package:appkinsonFront/views/HomeDifferentUsers/Doctor/DoctorHomePage.dart';

import 'package:appkinsonFront/views/Relations/DoctorPatients.dart';
import 'package:appkinsonFront/views/profiles/Doctor/DoctorProfile.dart';
import 'package:appkinsonFront/views/profiles/Doctor/profileEdition/ProfileEditionDoctor.dart';
import 'package:flutter/material.dart';

class RoutesDoctor {
  toDoctorHome(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => DoctorHomePage()));
  }

  toDoctorProfile(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MyHomePage2()));
  }

  toPatientList(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => DoctorPatients()));
  }

  toDoctorEditProfile(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ProfileEditionDoctor()));
  }
  
}
