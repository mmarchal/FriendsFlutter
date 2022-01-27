import 'package:flutter/material.dart';
import 'package:life_friends/model/typesortie.dart';

class DetailTypeSortie extends StatelessWidget {
  final TypeSortie typeSortie;

  const DetailTypeSortie({Key? key, required this.typeSortie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (typeSortie.id) {
      case 1:
        precacheImage(const AssetImage("asset/cinema.jpeg"), context);
        return Image.asset("asset/cinema.jpeg");
      case 2:
        precacheImage(const AssetImage("asset/sport.jpeg"), context);
        return Image.asset("asset/sport.jpeg");
      case 3:
        precacheImage(const AssetImage("asset/activite.jpeg"), context);
        return Image.asset("asset/activite.jpeg");
      default:
        return const SizedBox();
    }
  }
}
