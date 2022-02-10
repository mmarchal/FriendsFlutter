import 'package:flutter/material.dart';

class CopperPlateText extends Text {
  final String label;
  final Color color;

  CopperPlateText({Key? key, required this.label, required this.color})
      : super(label,
            textScaleFactor: 0.75,
            textAlign: TextAlign.center,
            style: TextStyle(color: color, fontFamily: "Copperplate"),
            key: key);
}
