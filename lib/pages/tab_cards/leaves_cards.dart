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
            mainAxisSpacing: 20,
            childAspectRatio: 3/2,
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              ServiceUtils().leavesContainer(context,"16/01/23", "18/01/23",
                  "Mid Sem Exams", "Paid Leave", "Approved", true),
              ServiceUtils().leavesContainer(context,"31/12/22", "01/01/23",
                  "New Year Leave", "Unpaid Leave", "InProgress", false),
              ServiceUtils().leavesContainer(context,"21/12/22", "22/12/22",
                  "Personal Leave", "Paid Leave", "Rejected", false),
              ServiceUtils().leavesContainer(context,"16/01/23", "18/01/23",
                  "Mid Sem Exams", "Paid Leave", "Approved", true),
              ServiceUtils().leavesContainer(context,"16/01/23", "18/01/23",
                  "Mid Sem Exams", "Paid Leave", "Approved", true),
            ],
          )),
      ),
    );
  }

}
