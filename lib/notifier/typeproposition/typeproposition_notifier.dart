import 'package:flutter/material.dart';
import 'package:life_friends/model/type_proposition.dart';

class TypePropositionNotifier extends ChangeNotifier {
  TypeProposition? typeProposition;

  TypePropositionNotifier({this.typeProposition});

  setTypeProposition(TypeProposition? typeProposition) {
    this.typeProposition = typeProposition;
    notifyListeners();
  }
}
