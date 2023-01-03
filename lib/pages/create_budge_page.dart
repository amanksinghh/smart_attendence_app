import 'dart:async';
import 'dart:convert';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_attendence_app/face_auth_puch/punch_out.dart';
import 'package:smart_attendence_app/pages/count_up_timer.dart';

import '../api_models/user_by_id_response.dart';
import '../dialogs/CustomProgressDialog.dart';
import '../face_auth_puch/punch_in.dart';
import '../json/create_budget_json.dart';
import '../theme/colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../utils/service_utilities.dart';

var profile_image =
    "https://media-exp1.licdn.com/dms/image/C5603AQEob5l8e06qQg/profile-displayphoto-shrink_800_800/0/1652278654609?e=1658361600&v=beta&t=IOrm1Y-2XbJ-wkn8Zy3ZGbcAssPC2gI4jfs4DyShYs4";

class CreatBudgetPage extends StatefulWidget {
  @override
  _CreatBudgetPageState createState() => _CreatBudgetPageState();
}

class _CreatBudgetPageState extends State<CreatBudgetPage> {
  int activeCategory = 0;
  late DateTime _lastButtonPress;
  String? _pressDuration;
  late Timer _ticker;
  bool isDialogShowing = false;
  String? authToken;

  Users? userById;

  getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString("authToken");
    print(authToken);
    getUsers();
    return authToken;
  }

  Future<void> getUsers() async {
    var url = 'https://attandance-server.onrender.com/user/${authToken}';
    Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){

      setState(() {
        var userListResponse = UserByIdResponse.fromJson(json.decode(response.body));
        var userDetails = userListResponse.users;
        userById = userDetails;
      });

    }
    else
    {
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
    getLoginData();
  }

  void functionThatSetsTheState(){
    setState(() {
      getUsers();
      _ticker.cancel();

    });
  }

  functionThatStartsTimer(){
    setState(() {
      getUsers();
      _lastButtonPress = DateTime.now();
      _updateTimer();
      _ticker = Timer.periodic(Duration(seconds:1),(_)=>_updateTimer());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  top: 40, right: 20, left: 20, bottom: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Feed",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      // Row(
                      //   children: [Icon(Icons.search)],
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 6,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, right: 20, left: 20, bottom: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: (size.width - 40) * 0.4,
                        child: Container(
                          child: Stack(
                            children: [
                              RotatedBox(
                                quarterTurns: -5,
                                child: CircularPercentIndicator(
                                    circularStrokeCap: CircularStrokeCap.round,
                                    backgroundColor: grey.withOpacity(0.5),
                                    radius: 60.0,
                                    lineWidth: 4.0,
                                    percent: 0.8,
                                    progressColor: black),
                              ),
                              Positioned(
                                top: 18,
                                left: 16,
                                child: Container(
                                  width: 85,
                                  height: 85,
                                  child: Center(
                                    child: Text(userById!.fullName
                                        .toString()
                                        .split("")[0][0],style: TextStyle(
                                        fontSize: (size.width - 40) * 0.2,
                                        color: primary
                                    ),),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: (size.width - 40) * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userById?.fullName ?? "",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              userById?.org ?? "",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black.withOpacity(0.4)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              userById?.designation ?? "",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black.withOpacity(0.4)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: grey.withOpacity(0.01),
                        boxShadow: [
                          BoxShadow(
                            color: grey.withOpacity(0.3),
                            spreadRadius: 10,
                            blurRadius: 3,
                            // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 2, right: 2, top: 25, bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_downward_outlined,
                                    color: black,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    userById?.entry ?? "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Punched In",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: black),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.punch_clock_rounded,
                                    color: primary,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    _pressDuration ?? "00:00:00",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: blue),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "WORKING HOUR ",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: black),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_upward_rounded,
                                    color: black,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    userById?.exit ?? "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Punched Out",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            // scrollDirection: Axis.horizontal,
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height ,
            child: Row(
                children: List.generate(categories.length, (index) {
                  return GestureDetector(
                onTap: () {

                    activeCategory = index;
                    switch (index) {
                      case 0:
                        checkIpAddress();
                        break;
                      case 1:
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const CountUpTimer()));
                        break;

                      case 2:
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PunchOut()))
                            .whenComplete(() => {functionThatSetsTheState()});
                        break;
                    }

                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 5,
                    ),
                    width: (size.width - 40) / categories.length,
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(
                            width: 2,
                            color: activeCategory == index
                                ? primary
                                : Color.fromARGB(144, 97, 94, 94)),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: grey.withOpacity(0.3),
                            spreadRadius: 10,
                            blurRadius: 3,
                            // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => const PunchIn())).whenComplete(() => {functionThatSetsTheState()});
                            },
                            child: Container(
                                width: 60,
                                height: 65,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: grey.withOpacity(0.1)),
                                child: Center(
                                  child: Image.asset(
                                    categories[index]['icon'],
                                    width: 70,
                                    height: 90,
                                    fit: BoxFit.contain,
                                  ),
                                )),
                          ),
                          Text(
                            categories[index]['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })),
          ),
          SizedBox(
            height: 10,
          ),
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
                  top: 10, right: 20, left: 20, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TIMELINE",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      // Row(
                      //   children: [Icon(Icons.search)],
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void _updateTimer() {
    final duration = DateTime.now().difference(_lastButtonPress);
    final newDuration = _formatDuration(duration);
    setState(() {
      _pressDuration = newDuration;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void checkIpAddress() async {
    showLoader(context);
    final ipv4 = await Ipify.ipv4();
    print(" IPV4 : ${ipv4}"); // 98.207.254.136
    final ipv6 = await Ipify.ipv64();
    print("IPV6 : ${ipv6}"); // 98.207.254.136 or 2a00:1450:400f:80d::200e
    final ipv4json = await Ipify.ipv64(format: Format.JSON);
    print(
        ipv4json); //{"ip":"98.207.254.136"} or {"ip":"2a00:1450:400f:80d::200e"}
    String checkIpv6 = "2409:4041:261e:e71a:7d43:d18:7e36:a6c0";
    if (ipv6 == checkIpv6) {
      hideLoader(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Connected to Organization Wifi."),
        backgroundColor: Colors.green,
      ));
      Navigator.push(
              context, MaterialPageRoute(builder: (context) => const PunchIn()))
          .whenComplete(() => {functionThatStartsTimer()});
    } else {
      hideLoader(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please Connect to Organization Wifi."),
        backgroundColor: Colors.red,
      ));
    }
  }
  showLoader(BuildContext context) {
    if (!isDialogShowing) {
      isDialogShowing = true;
      showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            return const CustomProgressDialog();
          }).then((value) {
        isDialogShowing = false;
      });
    }
  }

  hideLoader(BuildContext context) {
    if (isDialogShowing) {
      Navigator.pop(context);
    }
  }

}
