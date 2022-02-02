import 'package:flutter/material.dart';
import 'package:life_friends/model/sortie.dart';

class IconType {
  IconData getIconFromType(Sortie s) {
    switch (s.typeSortie.id) {
      case 1:
        return Icons.movie;
      case 2:
        return Icons.sports;
      case 3:
        return Icons.local_activity;
      default:
        return Icons.question_answer;
    }
  }
}
