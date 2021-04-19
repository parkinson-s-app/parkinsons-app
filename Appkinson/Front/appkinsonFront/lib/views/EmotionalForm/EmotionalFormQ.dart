import 'package:flutter/material.dart';

import '../EmotionalForm/EmotionalFormQ1.dart';
import '../EmotionalForm/EmotionalFormQ2.dart';

class EmotionalFormQ extends StatefulWidget {
  @override
  _EmotionalFormQ createState() => _EmotionalFormQ();
}

class _EmotionalFormQ extends State<EmotionalFormQ> {
  final controller = PageController(
    initialPage: 0,
  );

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Formulario emocional",
        ),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3.0),
          ),
        ],
      ),
      body: PageView(
        controller: controller,
        scrollDirection: Axis.vertical,
        children: [
          EmotionalFormQ1(),
          EmotionalFormQ2(),
        ],
      ),
    );
  }
}
