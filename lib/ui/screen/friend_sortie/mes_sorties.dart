// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/service/sortie.repository.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';
import 'package:life_friends/ui/widgets/button_login.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MesSorties extends StatefulWidget {
  final Gradient gradient;
  final String userId;

  const MesSorties({Key? key, required this.gradient, required this.userId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MesSortiesState();
  }
}

class MesSortiesState extends State<MesSorties> {
  static Widget _presentIcon(String day) => CircleAvatar(
        backgroundColor: Colors.green,
        child: Text(
          day,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      );

  final EventList<Event> _markedDateMap = EventList<Event>(
    events: {},
  );

  late CalendarCarousel _calendarCarouselNoHeader;
  List<DateTime> presentDates = [];

  late double cHeight;

  APIResponse<List<Sortie>>? apiSorties;

  @override
  void initState() {
    super.initState();
    loadMesSorties(context);
  }

  loadMesSorties(BuildContext context) async {
    final response = await context.read<SortieRepository>().getSorties();
    setState(() {
      apiSorties = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;
    if (apiSorties != null && apiSorties?.data != null) {
      for (int i = 0; i < apiSorties!.data!.length; i++) {
        Sortie s = apiSorties!.data![i];
        if (s.datePropose != null) {
          _markedDateMap.add(
            s.datePropose!,
            Event(
              date: s.datePropose!,
              title: s.intitule,
              description: s.typeSortie.type,
              location: s.lieu,
              icon: _presentIcon(
                s.datePropose!.day.toString(),
              ),
            ),
          );
        }
      }
    }

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: cHeight * 0.54,
      weekendTextStyle: const TextStyle(
        color: Colors.red,
      ),
      todayButtonColor: Colors.blue,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      onDayPressed: (p0, p1) {
        Event e = p1.firstWhere((element) => element.date == p0);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext bC) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: const EdgeInsets.only(top: 10.0),
                elevation: 10,
                title: Image.asset(
                  "asset/agenda.jpg",
                  height: 200,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Date de la sortie : ${DateFormat("dd/MM/yyyy").format(e.date)}"),
                    Text("Nom de la sortie : ${e.title ?? ""}"),
                    Text("Lieu prévu : ${e.location ?? ""}")
                  ],
                ),
                actions: [
                  ButtonLogin(onTap: () => Navigator.pop(context), title: "OK")
                ],
              );
            });
      },
      markedDateMoreShowTotal:
          null, // null for not showing hidden events indicator
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );
    return ScaffoldSortie(
      title: 'Mes sorties',
      gradient: widget.gradient,
      body: (apiSorties != null)
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _calendarCarouselNoHeader,
                  markerRepresent(Colors.green, "Present"),
                  widgetSortieSansDate(
                    apiSorties?.data ?? [],
                  )
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget markerRepresent(Color color, String data) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        radius: cHeight * 0.022,
      ),
      title: Text(
        data,
      ),
    );
  }

  widgetSortieSansDate(List<Sortie>? data) {
    List<Sortie> _liste = [];
    if (data != null) {
      for (Sortie s in data) {
        if (s.datePropose == null) _liste.add(s);
      }
    }
    return Column(
      children: _liste
          .map((e) => Container(
                margin: const EdgeInsets.all(16),
                child: Card(
                  elevation: 10,
                  child: Expanded(
                      child: ListTile(
                    title: Text(e.intitule),
                    subtitle: Text(e.lieu),
                  )),
                ),
              ))
          .toList(),
    );
  }
}
