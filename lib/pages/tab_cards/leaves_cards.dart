import 'package:flutter/material.dart';
import 'package:smart_attendence_app/utils/service_utilities.dart';


class LeavesCards extends StatefulWidget {
  const LeavesCards({Key? key}) : super(key: key);

  @override
  State<LeavesCards> createState() => _LeavesCardsState();
}

class _LeavesCardsState extends State<LeavesCards> {
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
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils().leavesContainer(
                    "16/01/23", "18/01/23", "Mid Sem Exams", "Paid Leave")),
                Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils().leavesContainer(
                    "31/12/22", "01/01/23", "New Year Leave", "Unpaid Leave")),
                Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils().leavesContainer(
                    "21/12/22", "22/12/22", "Personal Leave", "Paid Leave")),
                Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils().leavesContainer(
                    "16/01/23", "18/01/23", "Mid Sem Exams", "Paid Leave")),
                Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils().leavesContainer(
                    "16/01/23", "18/01/23", "Mid Sem Exams", "Paid Leave")),
          ],
            )),
      ),
    );
  }
}
