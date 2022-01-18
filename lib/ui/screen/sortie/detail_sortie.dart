import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_friends/model/sortie.dart';

class DetailSortie extends StatefulWidget {
  final Sortie sortie;

  const DetailSortie({Key? key, required this.sortie}) : super(key: key);

  @override
  _DetailSortieState createState() => _DetailSortieState();
}

class _DetailSortieState extends State<DetailSortie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sortie.intitule),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            child: Text(
                "Date : ${DateFormat('dd/MM/yyyy').format(widget.sortie.datePropose)}"),
          ),
          Card(
            elevation: 5,
            child: Text("Lieu : ${widget.sortie.lieu}"),
          ),
        ],
      ),
    );
  }
}
