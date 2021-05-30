import 'package:appkinsonFront/routes/RoutesGeneral.dart';
import 'package:appkinsonFront/routes/RoutesPatient.dart';
import 'package:appkinsonFront/services/EndPoints.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

int count = 0;
bool envio = false;
bool isPlaying;
bool isopen = false;

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.5, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    //print(progress);

    if (progress > 6.28 && envio == false) {
      envio = true;
      _sendScore();
      if (count != 0) {
        _CountDownTimerState().validationIsOpen(false);
      }
      //_CountDownTimerState().initState();
    }
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  Future _sendScore() async {
    if (count != 0) {
      await EndPoints().sendGameRecord(count);
    }
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    count = 0;
    envio = false;
    isPlaying = true;
    isopen = false;
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
  }

  void validationIsOpen(bool changeState) {
    print("HOLA 2.0");
    isopen = true;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.white10,
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.amber,
                    height:
                        controller.value * MediaQuery.of(context).size.height,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                      painter: CustomTimerPainter(
                                    animation: controller,
                                    backgroundColor: Colors.white,
                                    color: themeData.indicatorColor,
                                  )),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "¡Presiona tantas \nveces como puedas!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        timerString,
                                        style: TextStyle(
                                            fontSize: 60.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      !isPlaying
                          ? Column(children: [
                              SizedBox(
                                width: 250,
                                height: 250,
                                child: FloatingActionButton(
                                  heroTag: "btn1",
                                  child: Icon(
                                    Icons.fingerprint_rounded,
                                    size: 160,
                                  ),
                                  backgroundColor: Colors.green,
                                  onPressed: () {
                                    if (controller.value != 0.0) {
                                      setState(() {});
                                      count = count + 1;
                                      print("Se acabó el tiempo");
                                    }
                                    if (controller.value == 0.0) {
                                      print("Se acabó el tiempo");
                                    }
                                  },
                                ),
                              ),
                              Text(
                                '$count',
                                style:
                                    TextStyle(fontSize: 60, color: Colors.blue),
                              ),
                            ])
                          : SizedBox(
                              width: 250,
                              height: 250,
                              child: AnimatedBuilder(
                                  animation: controller,
                                  builder: (context, child) {
                                    return SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: FloatingActionButton.extended(
                                        isExtended: true,
                                        heroTag: "btn2",
                                        onPressed: () {
                                          controller.reverse(
                                              from: controller.value == 0.0
                                                  ? 1.0
                                                  : controller.value);
                                          if (controller.value == 1.0) {
                                            envio = false;
                                            print("Se acabó el tie");
                                            //Aquí llamar el servicio y si es diferente de 0 se guarda el resultado
                                            count = 0;
                                          }
                                          isPlaying = !isPlaying;
                                        },
                                        label: Text(
                                          "Empezar",
                                          style: TextStyle(fontSize: 50.0),
                                        ),
                                      ),
                                    );
                                  }))
                    ],
                  ),
                ),
                if (isopen)
                  AlertDialog(
                    title: Text("El juego ha terminado"),
                    content: Text('Su puntaje fue de $count'),
                    actions: [
                      FlatButton(
                        child: Text("Listo"),
                        onPressed: () {
                          isopen = false;
                          RoutesGeneral().toPop(context);
                          //RoutesPatient().toToolbox(context);
                        },
                      )
                    ],
                  )
              ],
            );
          }),
    );
  }
}

class Alert extends StatelessWidget {
//añadiendo comentario

  @override
  Widget build(BuildContext context) {
    print("hey");
    // TODO: implement build
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    return AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
  }
}

Widget button(bool isPlaying) {}
