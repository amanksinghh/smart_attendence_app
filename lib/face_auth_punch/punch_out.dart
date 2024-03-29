import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_models/user_put_location_response.dart';
import '../api_models/user_response.dart';
import '../dialogs/CustomProgressDialog.dart';

class PunchOut extends StatefulWidget {
  const PunchOut({Key? key}) : super(key: key);

  @override
  PunchOutState createState() => PunchOutState();
}

class PunchOutState extends State<PunchOut> {
  Users? userById;
  String? formattedDate;
  String? formattedTime;
  DateTime? date;
  bool isDialogShowing = false;
  late LocationPermission permission;
  Position? position;
  String long = "", lat = "";
  String? authToken;

  getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString("authToken");
    return authToken;
  }

  Future<void> putLatLong() async {
    showLoader(context);
    Map data = {
      "currLat": position?.latitude.toString(),
      "currLong": position?.longitude.toString(),
      "exit": formattedTime
    };
    //encode Map to JSON
    String body = json.encode(data);
    var url = 'https://attandance-server.onrender.com/user';
    Response response = await http.put(
      Uri.parse(url),
      body: body,
      headers: {"Content-Type": "application/json",
        'Authorization': 'Bearer $authToken'},
    );
    hideLoader(context);
    if (response.statusCode == 200) {
      var userPutResponse =
          UserPutLocationResponse.fromJson(json.decode(response.body));
        bool? success = userPutResponse.status;
        print(success);
        if(success == true){
          Fluttertoast.showToast(
              msg: "Punched Out Successfully.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
        }
        else{
          Fluttertoast.showToast(
              msg: "Please try again !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }

    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong. Try again !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    super.initState();
    getLoginData();
    setState(() {
      date = DateTime.now();
      formattedTime = DateFormat.jm().format(date!);
      formattedDate = DateFormat.MMMd().format(date!);
      getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Punch Out"),
        ),
        body: Center(
          child: MaterialButton(
            onPressed: () {
              putLatLong();
            },
            child: Text("Confirm Punch Out"),
            height: 50,
            minWidth: 100,
            color: Colors.blue,
            textColor: Colors.white,
          ),
        ));
  }

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
