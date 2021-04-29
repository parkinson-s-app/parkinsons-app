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

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    //print(progress);
    if (progress > 6.28 && envio == false) {
      envio = true;
      _sendScore();
      print("AQUIIII");
    }
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  Future _sendScore() async {
    await EndPoints().sendGameRecord(count);
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
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
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
              children: <Widget>[
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
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        timerString,
                                        style: TextStyle(
                                            fontSize: 100.0,
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
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: FloatingActionButton(
                          heroTag: "btn1",
                          child: Icon(
                            Icons.fingerprint_rounded,
                            size: 32,
                          ),
                          backgroundColor: Colors.green,
                          onPressed: () {
                            if (controller.value != 0.0) {
                              //print(controller.value);
                              setState(() {});
                              count = count + 1;
                            }
                            if (controller.value == 0.0) {
                              print("Se acabó el tiempo");
                            }
                            //debugPrint(controller.value.toString());
                          },
                        ),
                      ),
                      Text(
                        '$count',
                        style: TextStyle(fontSize: 50, color: Colors.blue),
                      ),
                      AnimatedBuilder(
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
                                    print("ENTRAAAAAA");

                                    envio = false;
                                    //Aquí llamar el servicio y si es diferente de 0 se guarda el resultado
                                    count = 0;
                                  }
                                },
                                label: Text("Empezar"),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
//añadiendo comentario
