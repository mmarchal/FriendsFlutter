import 'package:flutter/cupertino.dart';
import 'package:life_friends/model/typesortie.dart';

class TypeSortieNotifier extends ChangeNotifier {
  TypeSortie? typeSortie;

  TypeSortieNotifier({this.typeSortie});

  setTypeSortie(TypeSortie? typeSortie) {
    this.typeSortie = typeSortie;
    notifyListeners();
  }
}
