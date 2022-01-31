import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/service/friend.repository.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';
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

  List<DateTime> presentDates = [
    DateTime(2022, 01, 1),
    DateTime(2022, 01, 3),
    DateTime(2022, 01, 4),
    DateTime(2022, 01, 5),
    DateTime(2022, 01, 6),
    DateTime(2022, 01, 9),
    DateTime(2022, 01, 10),
    DateTime(2022, 01, 11),
    DateTime(2022, 01, 15),
    DateTime(2022, 01, 22),
    DateTime(2022, 01, 23),
  ];

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;
    for (int i = 0; i < presentDates.length; i++) {
      _markedDateMap.add(
        presentDates[i],
        Event(
          date: presentDates[i],
          title: 'Event 5',
          icon: _presentIcon(
            presentDates[i].day.toString(),
          ),
        ),
      );
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
}
