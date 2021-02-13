import 'dart:convert';

import 'package:appkinsonFront/model/User.dart';
import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:appkinsonFront/views/Login/Buttons/ButtonLogin.dart';
import 'package:appkinsonFront/views/profiles/Patient/profileEdition/ProfileEditionPatient.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

const bla = Colors.white;
const kSpacingUnit = 10;
File imageFile;

final kTitleTextStyle = TextStyle(
  fontFamily: "Raleway",
  fontSize: ScreenUtil().setSp(kSpacingUnit * 1.7),
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit * 1.3),
  fontWeight: FontWeight.w100,
  //fontFamily: "Raleway"
);

class PatientProfileScreen extends StatefulWidget {
  PatientProfileScreenP createState() => PatientProfileScreenP();
}

class PatientProfileScreenP extends State<PatientProfileScreen> {
  openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    var newUser = new User(photo: imageFile);
    String save = await EndPoints()
        .modifyUsersPhoto(newUser, currentUser['id'].toString(), token);
    RoutesGeneral().toPop(context);
  }

  openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);

    this.setState(() {
      imageFile = picture;
    });

    var newUser = new User(photo: imageFile);
    String save = await EndPoints()
        .modifyUsersPhoto(newUser, currentUser['id'].toString(), token);
    RoutesGeneral().toPop(context);
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Escoge:'),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Galería"),
                  onTap: () {
                    openGallery(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(6.0)),
                GestureDetector(
                  child: Text("Cámara"),
                  onTap: () async {
                    openCamera(context);
                    var m = new metod3();
                    //var user =  m.send();
                    var newUser = new User(photo: imageFile);
                    /*
                    debugPrint(user.name);
                    var lista = token.split(".");
                    var payload = lista[1];

                    switch (payload.length % 4) {
                      case 1:
                        break; // this case can't be handled well, because 3 padding chars is illeagal.
                      case 2:
                        payload = payload + "==";
                        break;
                      case 3:
                        payload = payload + "=";
                        break;
                    }

                    var decoded = utf8.decode(base64.decode(payload));
                    currentUser = json.decode(decoded);
                    debugPrint(currentUser['id'].toString());
                    */
                    debugPrint('aqui');
                    /*
                    String save = await EndPoints().modifyUsersPhoto(
                        newUser, currentUser['id'].toString(), token);
                        */
                    //debugPrint('aqui' + save);
                  },
                )
              ],
            )),
          );
        });
  }

  Widget decideImageView() {
    if (imageFile == null) {
      return Icon(LineAwesomeIcons.question);
    } else {
      return Image.file(
        imageFile,
        fit: BoxFit.cover,
        height: 100,
        width: 100,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    var profileInfo = Expanded(
        child: Column(
      children: [
        Container(
          height: 100,
          width: 100,
          margin: EdgeInsets.only(top: 50),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 50,
                child: ClipOval(
                  child: decideImageView(),
                ),

                backgroundImage: AssetImage("assets/images/user.png"),
                // backgroundImage: AssetImage(imageFile),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    height: 30,
                    width: 30,
                    child: FlatButton(
                      color: Colors.blue,
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              LineAwesomeIcons.camera,
                              //color: Colors.white,
                              size: ScreenUtil().setSp(25),
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        showChoiceDialog(context);
                      },
                      padding: EdgeInsets.all(1),
                      shape: CircleBorder(),
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          //currentUser['EMAIL'],
          nameController.text,
          style: kTitleTextStyle,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
            //currentUser['EMAIL']
            "h@gamil.com",
            style: kCaptionTextStyle),
        SizedBox(),
      ],
    ));
    var header = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          FlatButton(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    LineAwesomeIcons.arrow_left,
                    size: ScreenUtil().setSp(40),
                  ),
                )
              ],
            ),
            onPressed: () async {
              RoutesGeneral().toPop(context);
            },
            // padding: EdgeInsets.all(1),
            shape: CircleBorder(),
          ),
          profileInfo,
          SizedBox(
            width: 20,
          ),
          Icon(
            LineAwesomeIcons.sun,
            size: ScreenUtil().setSp(40),
          ),
          SizedBox(
            width: 40,
          ),
        ]);

    return Scaffold(
        body: Container(
            color: bla,
            child: Column(children: <Widget>[
              SizedBox(
                height: 20,
              ),
              header,
              SizedBox(
                height: 30,
              ),
              Expanded(
                  child: ListView(
                children: <Widget>[
                  ProfileListItem(
                    icon: LineAwesomeIcons.pen,
                    text: 'Editar',
                  ),
                  ProfileListItem(
                    icon: LineAwesomeIcons.helping_hands,
                    text: 'Ayuda & soporte',
                  ),
                  ProfileListItem(
                    icon: LineAwesomeIcons.question,
                    text: 'Acerca de nosotros',
                  ),
                  ProfileListItem(
                    icon: LineAwesomeIcons.comment,
                    text: 'Comentarios',
                  ),
                  ProfileListItem(
                    icon: LineAwesomeIcons.star,
                    text: 'Califícanos',
                  ),
                  ProfileListItem(
                    icon: Icons.exit_to_app,
                    text: 'Cerrar Sesión',
                  ),
                ],
              )),
            ])));
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final text;
  final bool hasNavigation;

  const ProfileListItem(
      {Key key, this.icon, this.text, this.hasNavigation = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        margin: EdgeInsets.symmetric(
          horizontal: 15,
        ).copyWith(
          bottom: 20,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Colors.grey[100],
          onPressed: () {
            if (text == 'Editar') {
              RoutesPatient().toPatientEditProfile(context);
            }
          },
          child: Row(
            children: <Widget>[
              Icon(this.icon, size: 25),
              SizedBox(
                width: 25,
              ),
              Text(
                this.text,
                style: kTitleTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              if (this.hasNavigation)
                Icon(
                  LineAwesomeIcons.angle_right,
                  size: 25,
                ),
            ],
          ),
        ));
  }
}

class metod3 {
  Future<User> send() async {
    var newUser = new User(photo: imageFile);
    debugPrint(newUser.name);
    return newUser;
  }
}
