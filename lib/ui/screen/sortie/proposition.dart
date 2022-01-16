import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_friends/ui/widgets/login_text.dart';
import 'package:life_friends/ui/widgets/selected_widget.dart';

class PropositionSortie extends StatefulWidget {
  const PropositionSortie({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PropositionSortieState();
  }
}

class PropositionSortieState extends State<PropositionSortie> {
  final TextEditingController _controllerTitle = TextEditingController();

  String? title;
  DateTime? selectedDateTime;
  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Proposition de sortie"),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            ElevatedButton.icon(
              onPressed: () {
                //to do recherche lieu
              },
              label: const Text("Choisir un lieu"),
              icon: const Icon(Icons.location_city),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                child: const Text("Valider"),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
