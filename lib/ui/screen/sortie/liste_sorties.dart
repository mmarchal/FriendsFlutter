import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/service/sortie.repository.dart';
import 'package:life_friends/ui/screen/sortie/detail_sortie.dart';

class ListeSorties extends StatefulWidget {
  const ListeSorties({Key? key}) : super(key: key);

  @override
  _ListeSortiesState createState() => _ListeSortiesState();
}

class _ListeSortiesState extends State<ListeSorties> {
  List<Sortie> sorties = [];

  @override
  void initState() {
    super.initState();

    SortieRepository().getSorties().then((value) {
      setState(() {
        sorties = value.data!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Liste des sorties"),
      ),
      body: ListView.builder(
        itemCount: sorties.length,
        itemBuilder: (context, index) {
          Sortie s = sorties[index];
          return InkWell(
            child: Card(
              elevation: 10,
              child: ListTile(
                title: Text(s.intitule),
                subtitle: Text(DateFormat("dd/MM/yyyy").format(s.datePropose)),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext bC) {
                return DetailSortie(
                  sortie: s,
                );
              }));
            },
          );
        },
      ),
    );
  }
}
