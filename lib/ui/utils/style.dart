import 'package:flutter/material.dart';

class Style {
  BoxDecoration boxDeco = const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff6bceff), Color(0xff6bceff)],
      ),
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)));

  SizedBox espace = const SizedBox(
    height: 10,
  );
}
