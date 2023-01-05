import 'package:flutter/material.dart';
import 'package:smart_attendence_app/utils/service_utilities.dart';


class MenuCards extends StatefulWidget {
  const MenuCards({Key? key}) : super(key: key);

  @override
  State<MenuCards> createState() => _MenuCardsState();
}

class _MenuCardsState extends State<MenuCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 1,
          mainAxisSpacing: 15,
          childAspectRatio: 7,
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils().menuItems("1.", "Tea", "Rs. 10")),
            Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils().menuItems("2.", "Samosa", "Rs. 20")),
            Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils().menuItems("3.", "Puff", "Rs. 20")),
            Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils().menuItems("4.", "Thali", "Rs. 120")),
            Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils().menuItems("5.", "Tea", "Rs. 10")),
            Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: kElevationToShadow[4]),
                child: ServiceUtils().menuItems("6.", "Tea", "Rs. 10")),
          ],
        ),
      ),
    );
  }
}
