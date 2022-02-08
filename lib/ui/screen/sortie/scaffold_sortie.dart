import 'package:flutter/material.dart';
import 'package:life_friends/model/sortie.dart';
// ignore: implementation_imports

class ScaffoldSortie extends StatelessWidget {
  final Gradient gradient;
  final String title;
  final Widget body;
  final Widget? actionAppBar;
  final bool? inscription;
  final Sortie? sortie;

  const ScaffoldSortie(
      {Key? key,
      required this.title,
      required this.body,
      this.inscription = false,
      this.sortie,
      required this.gradient,
      this.actionAppBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradient.colors[0],
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: gradient.colors[1],
        actions: [if (actionAppBar != null) actionAppBar!],
      ),
      body: body,
    );
  }
}
