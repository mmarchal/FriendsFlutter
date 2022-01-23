import 'package:flutter/material.dart';
import 'package:life_friends/model/typesortie.dart';

class DetailTypeSortie extends StatelessWidget {
  final TypeSortie typeSortie;

  const DetailTypeSortie({Key? key, required this.typeSortie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget w = const SizedBox();
    switch (typeSortie.id) {
      case 1:
        w = Image.asset("asset/cinema.jpeg");
        break;
      case 2:
        w = Image.asset("asset/sport.jpeg");
        break;
      case 3:
        w = Image.asset("asset/activite.jpeg");
        break;
      default:
        w = const SizedBox();
        break;
    }
    return w;
  }
}
