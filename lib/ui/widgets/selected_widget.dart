import 'package:flutter/material.dart';

class SelectedWidget extends StatelessWidget {
  final bool isSelected;
  final Widget selectedChild;
  final Widget notSelectedChild;
  final VoidCallback? onPressed;

  const SelectedWidget(
      {Key? key,
      required this.isSelected,
      required this.selectedChild,
      required this.notSelectedChild,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (isSelected)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              selectedChild,
              ElevatedButton(
                child: const Text("Modifier"),
                onPressed: onPressed,
              )
            ],
          )
        : notSelectedChild;
  }
}
