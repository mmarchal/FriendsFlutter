import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/service/friend.repository.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';
import 'package:life_friends/ui/widgets/icon_type.dart';
import 'package:provider/src/provider.dart';

// ignore: must_be_immutable
class MesSorties extends StatefulWidget {
  final Gradient gradient;
  final String userId;

  const MesSorties({Key? key, required this.gradient, required this.userId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MesSorties();
  }
}

class _MesSorties extends State<MesSorties> {
  APIResponse<List<Sortie>>? apiSorties;

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

  @override
  void initState() {
    super.initState();

    if (widget.userId != '') {
      FriendRepository().getMySorties(widget.userId).then((value) {
        setState(() {
          apiSorties = value;
        });
      });
    }
  }

  late double cHeight;

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;
    if (apiSorties != null && apiSorties!.data != null) {
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
            builder: (BuildContext bC) {
              return AlertDialog(
                elevation: 10,
                title: Text(e.getTitle() ?? ""),
                content: Text(e.location ?? ""),
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
                  widgetSortieSansDate(apiSorties!.data)
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
