import 'package:flutter/material.dart';
import 'package:life_friends/ui/widgets/copper_text.dart';

class ProfilInformationRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onPressed;

  const ProfilInformationRow(
      {Key? key,
      required this.label,
      required this.value,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CopperPlateText(
          label: label,
          color: Colors.black,
        ),
        CopperPlateText(
          label: value,
          color: Colors.black,
          fontStyle: FontStyle.italic,
        ),
        IconButton(onPressed: onPressed, icon: const Icon(Icons.edit))
      ],
    );
  }
}
