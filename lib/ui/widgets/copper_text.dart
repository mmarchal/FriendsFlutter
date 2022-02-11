// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

class CopperPlateText extends Text {
  final String label;
  final Color color;
  // ignore: overridden_fields
  final TextAlign? textAlign;
  final FontStyle? fontStyle;

  CopperPlateText(
      {Key? key,
      required this.label,
      required this.color,
      this.textAlign,
      this.fontStyle})
      : super(label,
            textScaleFactor: 0.75,
            textAlign: textAlign,
            style: TextStyle(
                color: color, fontFamily: "Copperplate", fontStyle: fontStyle),
            key: key);
}
