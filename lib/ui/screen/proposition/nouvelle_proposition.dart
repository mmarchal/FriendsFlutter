import 'package:flutter/material.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/ui/screen/proposition/formulaire.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';

class NouvelleProposition extends StatelessWidget {
  final Gradient gradient;

  const NouvelleProposition({Key? key, required this.gradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldSortie(
      title: 'Nouvelle proposition',
      body: AllFieldsForm(),
      gradient: gPropositions,
    );
  }
}
