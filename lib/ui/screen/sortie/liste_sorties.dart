// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/notifier/sortie/sortie_list_notifier.dart';
import 'package:life_friends/service/sortie.repository.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';
import 'package:life_friends/ui/widgets/icon_type.dart';
import 'package:provider/src/provider.dart';

class ListSorties extends StatefulWidget {
  const ListSorties({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListeSortiesState();
  }

}

class ListeSortiesState extends State<ListSorties> {

  APIResponse<List<Sortie>>? response;

  _initBody(List<Sortie>? data) {
    if (data != null && data.isNotEmpty) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          Sortie s = data[index];
          return InkWell(
            child: Card(
              margin: const EdgeInsets.all(16),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: const Color(0xFF424B5E),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    IconType().getIconFromType(s),
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
                            ? DateFormat("dd/MM/yyyy").format(s.datePropose!)
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
              Provider.of<SortieListNotifier>(context, listen: false)
                  .loadOneSortie(sortieId: s.id.toString());
              Navigator.pushNamed(context, '/detail_sortie');
            },
          );
        },
      );
    } else {
      return const Center(
        child: Text(
          "Aucune sortie trouvé !",
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllSorties(context);
  }
  @override
  Widget build(BuildContext context) {
    return ScaffoldSortie(
      title: "Liste des sorties",
      body: (response == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _initBody(response!.data),
      gradient: gNextSorties,
    );
  }

  Future<void> getAllSorties(BuildContext context) async {
    APIResponse<List<Sortie>> api = await context.read<SortieRepository>().getSorties();
    setState(() {
      response = api;
    });
  }
}
