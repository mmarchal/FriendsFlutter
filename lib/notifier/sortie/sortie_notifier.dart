import 'package:flutter/material.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/service/sortie.repository.dart';

class SortieNotifier extends ChangeNotifier {
  List<Sortie> _sorties = [];

  Future loadSorties() async {
    try {
      SortieRepository().getSorties().then((value) {
        List<Sortie> sorties = value.data!;
        for (var element in sorties) {
          _sorties.add(element);
        }
      });
    } catch (error) {
      print(error);
    }
  }
}
