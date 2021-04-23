import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Carer/CarerHomePage.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Doctor/DoctorHomePage.dart';
import 'package:appkinsonFront/views/HomeDifferentUsers/Patient/PatientHomePage.dart';
import 'package:appkinsonFront/views/RelationRequest/relationsRequets.dart';
import 'package:appkinsonFront/views/profiles/Carer/CarerProfileScreen.dart';
import 'package:appkinsonFront/views/profiles/Doctor/DoctorProfileScreen.dart';
import 'package:appkinsonFront/views/profiles/Patient/PatientProfile.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:appkinsonFront/views/profiles/Patient/PatientProfileScreen.dart';
import 'package:appkinsonFront/views/profiles/Patient/profileEdition/ProfileEditionPatient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/src/widgets/safe_area.dart';
import '../HomeInitial/HomePage.dart';

class CustomDrawerMenu extends StatelessWidget {
  final Function closeDrawer;

  const CustomDrawerMenu({Key key, this.closeDrawer}) : super(key: key);

  Widget decideImage() {
    if (imageFilePatient == null) {
      return Image.asset(
        "assets/images/user.png",
        width: 100,
        height: 100,
      );
    } else {
      return Image.file(
        imageFilePatient,
        fit: BoxFit.cover,
        height: 100,
        width: 100,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.blue,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey.withAlpha(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child: decideImage(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(nameController.text)
                ],
              )),
          Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () async {
              debugPrint("Tapped Profile");
              String tipe = await Utils().getFromToken('type');
              if (tipe == 'Cuidador') {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => CarerProfileScreen()));
              }
              if (tipe == 'Doctor') {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => DoctorProfileScreen()));
              }
            },
            leading: Icon(Icons.person),
            title: Text(
              "Tu perfil",
            ),
          ),
          /*Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped settings");

            },
            leading: Icon(Icons.settings),
            title: Text("Ajustes"),
          ),*/
          Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () async {
              String tipe = await Utils().getFromToken('type');
              if (tipe == 'Cuidador') {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => CarerHomePage()));
              }
              if (tipe == 'Doctor') {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => DoctorHomePage()));
              }
            },
            leading: Icon(Icons.home),
            title: Text("Ir al Home"),
          ),
        ],
      ),
    );
  }
}
