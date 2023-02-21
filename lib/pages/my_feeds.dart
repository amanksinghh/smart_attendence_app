import 'dart:async';
import 'dart:convert';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_attendence_app/face_auth_punch/punch_out.dart';

import '../api_models/responses/user_by_id_response.dart';
import '../dialogs/CustomProgressDialog.dart';
import '../face_auth_punch/face_match.dart';
import '../json/create_budget_json.dart';
import '../theme/colors.dart';

class MyFeedsPage extends StatefulWidget {
  const MyFeedsPage({super.key});

  @override
  _MyFeedsPageState createState() => _MyFeedsPageState();
}

class _MyFeedsPageState extends State<MyFeedsPage> {
  int activeCategory = 0;
  late DateTime _lastButtonPress;
  String? _pressDuration;
  late Timer _ticker;
  bool isDialogShowing = false;
  String? authToken;
  String? formattedDate;

  late LocationPermission permission;
  Position? position;
  String? long, lat;
  double kmDistance = 0.00;
  double distanceBetween = 0.00;

  Users? userById;
  Userdetails? _userdetails;

  bool isPunchedIn = false;

  ///getting the auth_token from local storage.
  getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString("authToken");
    getUsers();
    return authToken;
  }

  ///calling the api to get user_details.
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
        _userdetails = userById?.userdetails;
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
    getLoginData();
    setState(
      () {
        formattedDate = DateFormat.jm().format(DateTime.now());
        getLocation();
      },
    );
  }

  ///function to stop working hour timer called after punch_out screen.
  void functionThatSetsTheState() {
    setState(() {
      getUsers();
      _ticker.cancel();
      isPunchedIn = false;
    });
  }

  ///function to start working hour timer called after punch_in screen.
  functionThatStartsTimer() {
    setState(() {
      isPunchedIn = true;
      getUsers();
      _lastButtonPress = DateTime.now();
      _updateTimer();
      _ticker =
          Timer.periodic(const Duration(seconds: 1), (_) => _updateTimer());
      hideLoader(context);
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
                    children: const [
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
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
                                    percent: 1,
                                    progressColor: Colors.blue),
                              ),
                              Positioned(
                                top: 18,
                                left: 16,
                                child: Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${userById?.userPhoto}"),
                                          fit: BoxFit.cover)),
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
                              userById?.fullName!.firstName ?? "",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              _userdetails?.org ?? "--",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black.withOpacity(0.4)),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              _userdetails?.designation ?? "--",
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
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: primary.withOpacity(0.01),
                            spreadRadius: 10,
                            blurRadius: 3,
                            // changes position of shadow
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_downward_outlined,
                                    color: white,
                                    size: 25,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    userById?.entry ?? "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Punched In",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: white),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.punch_clock_rounded,
                                    color: white,
                                    size: 25,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    _pressDuration ?? "00:00:00",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: white),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "WORKING HOUR ",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: white),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_upward_rounded,
                                    color: white,
                                    size: 25,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    userById?.exit ?? "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: white),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Punched Out",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
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
                      demoToast();
                      break;
                    case 2:
                      checkPunchedIn();
                      break;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 5,
                    ),
                    width: (size.width - 40) / categories.length,
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(
                            width: 2,
                            color: activeCategory == index
                                ? Colors.blue
                                : const Color.fromARGB(144, 97, 94, 94)),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: kElevationToShadow[5]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
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
                            style: const TextStyle(
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
          const SizedBox(
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
                    children: const [
                      Text(
                        "TIMELINE",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///function for working hours update.
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

  ///for checking ip_address on hitting punch_in.
  checkIpAddress() async {
    showLoader(context);
    final ipv4 = await Ipify.ipv4();
    print(" IPV4 : $ipv4");
    final ipv6 = await Ipify.ipv64();
    print("IPV6 : $ipv6");
    String checkIpv6 = "49.34.132.168";

    //checkLocation();

    hideLoader(context);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FaceMatch(imageString: userById?.userFaceData![0] ?? "assets/images/image.JPG",)))
        .whenComplete(() => {functionThatStartsTimer()});

    // Navigator.push(
    //              context, MaterialPageRoute(builder: (context) => const LoginPage()));
    // Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => const PunchIn()))
    //     .whenComplete(() => {functionThatStartsTimer()});
    // if (ipv4 == checkIpv6) {
    //   hideLoader(context);
    //   if(isPunchedIn == true){
    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text("Already punched in !"),
    //       backgroundColor: Colors.red,
    //     ));
    //   }
    //   else{
    //     Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => const PunchIn()))
    //         .whenComplete(() => {functionThatStartsTimer()});
    //   }
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text("Connected to Organization Wifi."),
    //     backgroundColor: Colors.green,
    //   ));
    // } else {
    //   hideLoader(context);
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text("Please Connect to Organization Wifi."),
    //     backgroundColor: Colors.red,
    //   ));
    // }
  }

  ///after ip_address it will check for user_location.
  checkLocation() {
    lat = position?.latitude.toString();
    long = position?.longitude.toString();
    distanceBetween = Geolocator.distanceBetween(
      double. parse(userById?.orgLatitude ?? ""),
      double.parse(userById?.orgLongitude ?? ""),
      position?.latitude ?? 0.00,
      position?.longitude ?? 0.00,
    );
    kmDistance = distanceBetween / 1000;
    if (kmDistance <= 1) {
      hideLoader(context);
      Navigator.push(context,
              MaterialPageRoute(builder: (context) => FaceMatch(imageString: userById?.userFaceData![0] ?? "assets/images/image.JPG",)))
          .whenComplete(() => {functionThatStartsTimer()});
    } else {
      hideLoader(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You are out of Organization."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  ///getting user location.
  getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Permission not granted");
      Geolocator.requestPermission();
    } else {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print(position!.latitude.toString());
      print(position!.longitude.toString());
    }
  }

  ///checking if user is punched_in or not before opening punch_out.
  checkPunchedIn() {
    if (isPunchedIn == true) {
      Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PunchOut()))
          .whenComplete(() => {functionThatSetsTheState()});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please punch in first !"),
        backgroundColor: Colors.red,
      ));
    }
  }

  demoToast() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Updating Soon !"),
      backgroundColor: Colors.red,
    ));
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
