import 'package:flutter/material.dart';
import 'package:life_friends/ui/widgets/copper_text.dart';

class ProfilInformationRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onPressed;
  final bool updated;

  const ProfilInformationRow(
      {Key? key,
      required this.label,
      required this.value,
      required this.onPressed,
      this.updated = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CopperPlateText(
            label: label,
            color: Colors.black,
          ),
          CopperPlateText(
            label: value,
            color: (updated) ? Colors.green : Colors.black,
            fontStyle: FontStyle.italic,
          ),
          IconButton(onPressed: onPressed, icon: const Icon(Icons.edit))
        ],
      ),
    );
  }
}
