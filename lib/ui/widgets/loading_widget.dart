import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String label;

  const LoadingWidget({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Text(label),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
