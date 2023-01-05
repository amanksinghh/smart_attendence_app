import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/service_utilities.dart';


class ExpensesCards extends StatefulWidget {
  const ExpensesCards({Key? key}) : super(key: key);

  @override
  State<ExpensesCards> createState() => _ExpensesCardsState();
}

class _ExpensesCardsState extends State<ExpensesCards> {

  late DateTime targetMonth, initialDate;
  late String month, year;
  int noOfDaysCurrentMonth = 0;
  String? formattedDated;

  @override
  void initState() {
    super.initState();
    targetMonth = DateTime.now();
    initialDate = DateTime.now();
    formattedDated = DateFormat.yMd().format(initialDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Select Date",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: initialDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now());
                      if (pickedDate != null) {
                        setState(() {
                          //ServiceUtils.printLog("pickedDate $pickedDate");
                          if (pickedDate.month ==
                              DateTime.now().month) {
                            targetMonth = DateTime(
                                pickedDate.year,
                                pickedDate.month,
                                DateTime.now().day);
                          } else {
                            targetMonth = DateTime(pickedDate.year,
                                pickedDate.month, 1);
                          }
                          //ServiceUtils.printLog("targetMonth $targetMonth");
                          initialDate = DateTime(pickedDate.year,
                              pickedDate.month, pickedDate.day);
                          formattedDated =
                              DateFormat.yMd().format(initialDate);
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month,
                            color: Colors.blue,),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "$formattedDated",
                            style: const TextStyle(
                                fontSize: 17, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            GridView.count(
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
                child: ServiceUtils().expenseContainer(
                    "11:00 AM", formattedDated!, "Cafeteria Breakfast", "100")),
                Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils().expenseContainer(
                    "02:00 PM", formattedDated!, "Cafeteria Lunch", "200")),
                Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils().expenseContainer(
                    "05:00 PM", formattedDated!, "Cafeteria Tea", "20")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
