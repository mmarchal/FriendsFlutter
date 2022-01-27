import 'package:flutter/material.dart';

class ScaffoldSortie extends StatelessWidget {
  final String title;
  final Widget body;
  const ScaffoldSortie({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3B4254),
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: const Color(0xFF3B4254),
      ),
      body: body,
    );
  }
}
