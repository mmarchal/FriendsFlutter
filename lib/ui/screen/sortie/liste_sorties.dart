import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/service/sortie.repository.dart';
import 'package:life_friends/ui/screen/sortie/detail_sortie.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';

class ListeSorties extends StatefulWidget {
  const ListeSorties({Key? key}) : super(key: key);

  @override
  _ListeSortiesState createState() => _ListeSortiesState();
}

class _ListeSortiesState extends State<ListeSorties> {
  APIResponse<List<Sortie>>? apiSorties;

  ///To do --> Style à modifier
  ///https://miro.medium.com/max/910/1*xvCsoq7iYcznw1Xy5A8Jng.png

  @override
  void initState() {
    super.initState();

    SortieRepository().getSorties().then((value) {
      setState(() {
        apiSorties = value;
      });
    });
  }

  _initBody() {
    Widget? body;
    setState(() {
      if (apiSorties == null) {
        body = const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (apiSorties!.isSuccess && apiSorties!.data!.isNotEmpty) {
          List<Sortie> sorties = apiSorties!.data!;
          body = ListView.builder(
            itemCount: sorties.length,
            itemBuilder: (context, index) {
              Sortie s = sorties[index];
              return InkWell(
                child: Card(
                  margin: const EdgeInsets.all(16),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: const Color(0xFF424B5E),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                      const VerticalDivider(
                        width: 5,
                      ),
                      Expanded(
                          child: ListTile(
                        title: Text(
                          s.intitule,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                            (s.datePropose != null)
                                ? DateFormat("dd/MM/yyyy")
                                    .format(s.datePropose!)
                                : "-",
                            style: const TextStyle(color: Colors.white)),
                      )),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.navigate_next),
                      )
                    ],
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
          );
        } else {
          body = const Center(
            child: Text(
              "Aucune sortie trouvé !",
              style:
                  TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
            ),
          );
        }
      }
    });
    return body;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldSortie(title: "Liste des sorties", body: _initBody());
  }
}
