import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/model/typesortie.dart';
import 'package:life_friends/notifier/typesortie/typesortie_list_notifier.dart';
import 'package:life_friends/service/sortie.repository.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';
import 'package:life_friends/ui/widgets/login_text.dart';
import 'package:life_friends/ui/widgets/selected_widget.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class PropositionSortie extends StatefulWidget {
  const PropositionSortie({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PropositionSortieState();
  }
}

class PropositionSortieState extends State<PropositionSortie> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerLocation = TextEditingController();

  String? title;
  DateTime? selectedDateTime;
  String? selectedLocation;
  int? selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    final List<TypeSortie>? liste =
        context.watch<TypeSortieListNotifier>().listeTypes;
    _selectDate(BuildContext context) async {
      final DateTime? selected = await showDatePicker(
        context: context,
        initialDate:
            (selectedDateTime != null) ? selectedDateTime! : DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2025),
      );
      if (selected != null && selected != selectedDateTime) {
        setState(() {
          selectedDateTime = selected;
        });
      }
    }

    return ScaffoldSortie(
      title: "Proposition de sortie",
      gradient: gNewSortie,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(30),
          children: [
            LoginText(
              hint: "Titre de la proposition",
              icon: Icons.title,
              controller: _controllerTitle,
            ),
            SelectedWidget(
              isSelected: (selectedDateTime != null),
              selectedChild: Text((selectedDateTime != null)
                  ? DateFormat("dd/MM/yyyy").format(selectedDateTime!)
                  : ""),
              notSelectedChild: ElevatedButton.icon(
                onPressed: () {
                  _selectDate(context);
                },
                icon: const Icon(Icons.calendar_today),
                label: const Text("Choisir une date"),
              ),
              onPressed: () {
                _selectDate(context);
              },
            ),
            LoginText(
              hint: "Lieu de la proposition",
              icon: Icons.location_city,
              controller: _controllerLocation,
            ),
            (liste != null)
                ? Column(
                    children: liste
                        .map((element) => RadioListTile<int>(
                              title: Text(element.type),
                              activeColor: Colors.white,
                              onChanged: (int? b) {
                                setState(() {
                                  selectedValue = b;
                                });
                              },
                              value: element.id!,
                              groupValue: selectedValue,
                            ))
                        .toList(),
                  )
                : const CircularProgressIndicator(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                child: const Text("Valider"),
                onPressed: () async {
                  Sortie sortie = Sortie(
                      datePropose: selectedDateTime,
                      intitule: _controllerTitle.text,
                      lieu: _controllerLocation.text,
                      typeSortie: TypeSortie(id: selectedValue, type: ''));
                  APIResponse<bool> response =
                      await SortieRepository().addOuting(sortie);
                  if (response.isSuccess && response.data!) {
                    await CoolAlert.show(
                      context: context,
                      type: CoolAlertType.success,
                      text: 'Sortie enregistré !',
                      onConfirmBtnTap: () => Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false),
                    );
                  } else {
                    await CoolAlert.show(
                        context: context,
                        type: CoolAlertType.error,
                        title: response.error!.title,
                        text: response.error!.content);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
