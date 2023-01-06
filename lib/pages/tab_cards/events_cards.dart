import 'package:flutter/material.dart';

import '../../utils/service_utilities.dart';


class EventsCards extends StatefulWidget {
  const EventsCards({Key? key}) : super(key: key);

  @override
  State<EventsCards> createState() => _EventsCardsState();
}

class _EventsCardsState extends State<EventsCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView.count(
        crossAxisCount: 1,
        mainAxisSpacing: 20,
        childAspectRatio: 2 / 1,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          ServiceUtils()
              .eventsContainer("New Year Bash", "01/02/23", "Tower 2", "1"),
          ServiceUtils().eventsContainer(
              "Christmas Eve", "25/12/22", "Office Roof", "2"),
          ServiceUtils()
              .eventsContainer("Tech Fest", "16/12/22", "Seminar Hall", "3"),
          ServiceUtils()
              .eventsContainer("New Year Bash", "18/01/23", "Farms", "4"),
          ServiceUtils()
              .eventsContainer("New Year Bash", "18/01/23", "Farms", "5"),
          ServiceUtils()
              .eventsContainer("New Year Bash", "18/01/23", "Farms", "6"),
        ],
          ),
      ),
    );
  }
}
