//import 'package:appkinsonFront/views/profiles/Patient/PatientProfileScreen.dart';
import 'package:appkinsonFront/routes/RoutesDoctor.dart';
import 'package:appkinsonFront/utils/Utils.dart';
import 'package:appkinsonFront/views/profiles/Doctor/profileEdition/ProfileEditionDoctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipedetector/swipedetector.dart';

import 'DoctorProfileScreen.dart';

const bla = Colors.white;
const kSpacingUnit = 10;
//File imageFile;

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

class MyHomePage2 extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage2> {
  FSBStatus drawerStatus;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SwipeDetector(
          onSwipeRight: () {
            setState(() {
              drawerStatus = FSBStatus.FSB_OPEN;
            });
          },
          onSwipeLeft: () {
            setState(() {
              drawerStatus = FSBStatus.FSB_CLOSE;
            });
          },
          child: FoldableSidebarBuilder(
            drawerBackgroundColor: Colors.blue[800],
            drawer: CustomDrawer(
              closeDrawer: () {
                setState(() {
                  drawerStatus = FSBStatus.FSB_CLOSE;
                });
              },
            ),
            screenContents: DoctorProfileScreen(),
            status: drawerStatus,
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue[800],
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
                    ? FSBStatus.FSB_CLOSE
                    : FSBStatus.FSB_OPEN;
              });
            }),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  Widget decideImage() {
    if (imageFileDoctor == null) {
      return Image.asset(
        "assets/images/user.png",
        width: 100,
        height: 100,
      );
    } else {
      return Image.file(
        imageFileDoctor,
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
                  Text(nameControllerDoctor.text)
                ],
              )),
          Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Profile");
            },
            leading: Icon(Icons.person),
            title: Text(
              "Tu Perfil",
            ),
          ),
          Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped settings");
            },
            leading: Icon(Icons.settings),
            title: Text("Ajustes"),
          ),
          Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Payments");
              RoutesDoctor().toDoctorHome(context);
            },
            leading: Icon(Icons.home),
            title: Text("Ir al Home"),
          ),
          Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Notifications");
            },
            leading: Icon(Icons.notifications),
            title: Text("Notificaciones"),
          ),
          Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () async {
              debugPrint("Tapped Log Out");
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs?.clear(); 
              await Utils().removeBackgroundTask();
              Navigator.popUntil(context, ModalRoute.withName("/"));
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Cerrar Sesión"),
          ),
        ],
      ),
    );
  }
}

/*class PatientProfile extends StatelessWidget {
  openGallery() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  openCamera() {}

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
                  child: Text("Galeria"),
                  onTap: () {
                    openGallery();
                  },
                ),
                Padding(padding: EdgeInsets.all(6.0)),
                GestureDetector(
                  child: Text("Camara"),
                  onTap: () {
                    openCamera();
                  },
                )
              ],
            )),
          );
        });
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
                backgroundImage: AssetImage("assets/images/user.png"),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    height: 40,
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
          'Camilo Hoyos',
          style: kTitleTextStyle,
        ),
        SizedBox(
          height: 5,
        ),
        Text('cami.Hoyos@gmail.com', style: kCaptionTextStyle),
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
            onPressed: () {},
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
                    text: 'Calificanos',
                  ),
                  ProfileListItem(
                    icon: Icons.exit_to_app,
                    text: 'Cerrar Sesión',
                  ),
                ],
              )),
            ])));
  }
}*/

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
          onPressed: () {},
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
