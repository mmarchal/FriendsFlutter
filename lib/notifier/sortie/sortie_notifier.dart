import 'package:flutter/material.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/service/sortie.repository.dart';

class SortieNotifier extends ChangeNotifier {
  final List<Sortie> _sorties = [];
}
