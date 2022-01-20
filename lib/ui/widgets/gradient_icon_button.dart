import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;

class GradientIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Gradient gradient;
  final String label;

  const GradientIconButton(
      {Key? key,
      required this.onPressed,
      required this.icon,
      required this.gradient,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return a.GradientElevatedButton.icon(
      onPressed: onPressed,
      gradient: gradient,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
