import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_models/responses/user_by_id_response.dart';

import '../../theme/colors.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({Key? key}) : super(key: key);

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
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
  late List<Logs> graphData = [];

  getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString("authToken");
    getUsers();
    return authToken;
  }

  Future<void> getUsers() async {
    var url = 'https://attandance-server.onrender.com/user';
    Response response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $authToken',
    });
    if (response.statusCode == 200) {
      setState(() {
        var userListResponse =
        UserByIdResponse.fromJson(json.decode(response.body));
        var userDetails = userListResponse.users;
        userById = userDetails;
        var graphDataList = userDetails?.logs;
        graphData.clear();
        if (graphDataList != null && graphDataList.isNotEmpty) {
          setState(() {
            graphData.addAll(graphDataList);
          });
        }
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
                    if (pickedDate.month == DateTime.now().month) {
                      targetMonth = DateTime(pickedDate.year, pickedDate.month,
                          DateTime.now().day);
                    } else {
                      targetMonth =
                          DateTime(pickedDate.year, pickedDate.month, 1);
                    }
                    //ServiceUtils.printLog("targetMonth $targetMonth");
                    initialDate = DateTime(
                        pickedDate.year, pickedDate.month, pickedDate.day);
                    formattedDated = DateFormat.yMd().format(initialDate);
                    print(formattedDated);
                    graphFormattedDate =
                        DateFormat('yyyy-MM-dd').format(initialDate);
                    print(graphFormattedDate);
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "$formattedDated",
                      style: const TextStyle(fontSize: 17, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 1,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(color: grey, offset: Offset(0, 1), blurRadius: 1)
          ]),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
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
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      userById?.entry ?? "--/--",
                      style: const TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: 16,
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
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      userById?.exit ?? "--/--",
                      style: const TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // FutureBuilder<List<Logs>>(
        //   builder: (context, snapshot){
        //     if(snapshot.hasData){
        //       if(snapshot.data!.isNotEmpty){
        //         return
        //       }
        //       else{
        //         return const Center(child: Text("Empty monthly data"));
        //       }
        //     }
        //     else{
        //       return const Center(child: Text("Error in Collecting Data"),);
        //     }
        //
        //   },
        // ),
      ],
    );
  }
}
