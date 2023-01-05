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
        child: Center(
            child: GridView.count(
              crossAxisCount: 1,
              mainAxisSpacing: 30,
              childAspectRatio: 2.3,
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils()
                    .eventsContainer("New Year Bash", "01/02/23", "Tower 2", "1")),
                Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils()
                    .eventsContainer("Christmas Eve", "25/12/22", "Office Roof", "2")),
                Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils()
                    .eventsContainer("Tech Fest", "16/12/22", "Seminar Hall", "3")),
                Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils()
                    .eventsContainer("New Year Bash", "18/01/23", "Farms", "4")),
                Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils()
                    .eventsContainer("New Year Bash", "18/01/23", "Farms", "5")),
                Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils()
                    .eventsContainer("New Year Bash", "18/01/23", "Farms", "6")),
          ],
            )),
      ),
    );
  }
}
