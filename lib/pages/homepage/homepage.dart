import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_models/user_by_id_response.dart';
import '../../json/day_month.dart';
import '../../theme/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeDay = 3;
  TextEditingController searchController = TextEditingController();
  bool searchbarVisible = false;
  String? formattedDate;
  DateTime? date;
  late DateTime targetMonth, initialDate;
  late String month, year;
  int noOfDaysCurrentMonth = 0;
  String? formattedDated;
  String? graphFormattedDate;
  bool isDataRefreshed = false, isCountRefreshed = false;
  String? authToken;
  Users? userById;

  getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString("authToken");
    getUsers();
    return authToken;
  }

  Future<void> getUsers() async {
    var url = 'https://attandance-server.onrender.com/user/${authToken}';
    Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        var userListResponse =
            UserByIdResponse.fromJson(json.decode(response.body));
        var userDetails = userListResponse.users;
        userById = userDetails;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong !"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          dismissDirection: DismissDirection.down,
          elevation: 10,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    targetMonth = DateTime.now();
    initialDate = DateTime.now();
    formattedDated = DateFormat.yMd().format(initialDate);
    graphFormattedDate = DateFormat('yyyy-MM-dd').format(initialDate);
    getLoginData();
    setState(() {
      date = DateTime.now();
      formattedDate = DateFormat.MMMd().format(date!);
    });
  }

  @override
  Widget build(BuildContext context) {
    getLoginData();
    return Scaffold(
        backgroundColor: grey.withOpacity(0.05),
        body: RefreshIndicator(
            onRefresh: () async {
              await getUsers();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: white, boxShadow: [
                      BoxShadow(
                        color: grey.withOpacity(0.01),
                        spreadRadius: 10,
                        blurRadius: 3,
                        // changes position of shadow
                      ),
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 50, right: 20, left: 20, bottom: 25),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Attendence Summary",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: black),
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
                                      isDataRefreshed = false;
                                      isCountRefreshed = false;
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
                                      print(formattedDated);
                                      graphFormattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(initialDate);
                                      print(graphFormattedDate);
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
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(days.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      activeDay = index;
                                    });
                                  },
                                  child: Container(
                                    width: (MediaQuery.of(context).size.width -
                                            40) /
                                        7,
                                    child: Column(
                                      children: [
                                        Text(
                                          days[index]['label'],
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: activeDay == index
                                                  ? primary
                                                  : Colors.transparent,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: activeDay == index
                                                      ? primary
                                                      : black
                                                          .withOpacity(0.1))),
                                          child: Center(
                                            child: Text(
                                              days[index]['day'],
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: activeDay == index
                                                      ? white
                                                      : black),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        margin: const EdgeInsets.only(left: 6, right: 6),
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(2, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(),
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                child: Center(
                                  child: Text(
                                    formattedDate.toString(),
                                    style: const TextStyle(
                                      fontFamily: "NexaBold",
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Punch In",
                                    style: TextStyle(
                                      fontFamily: "NexaRegular",
                                      fontSize: 20,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    userById?.entry ?? "--/--",
                                    style: const TextStyle(
                                      fontFamily: "NexaBold",
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Punch Out",
                                    style: TextStyle(
                                      fontFamily: "NexaRegular",
                                      fontSize: 20,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    userById?.exit ?? "--/--",
                                    style: const TextStyle(
                                      fontFamily: "NexaBold",
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            )));
  }
}
