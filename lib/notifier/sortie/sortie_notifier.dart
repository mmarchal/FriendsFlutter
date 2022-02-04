import 'package:flutter/material.dart';
import 'package:life_friends/model/sortie.dart';

class SortieNotifier extends ChangeNotifier {
  Sortie? sortie;

  SortieNotifier({this.sortie});

  setTypeSortie(Sortie? sortie) {
    this.sortie = sortie;
    notifyListeners();
  }
}
